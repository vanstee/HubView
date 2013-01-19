#import "CommitView.h"

#import "Comment.h"
#import "Commit.h"
#import "CommitLevelCommentThreadView.h"
#import "FileView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommitView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = YES;
        self.backgroundColor = [UIColor underPageBackgroundColor];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setPartialCommit:(Commit *)commit
{
    self.commit = nil;
    self.comments = nil;

    [commit commitWithCompletionBlock:^(Commit *commit) { self.commit = commit; }];
    [commit commentsWithCompletionBlock:^(NSArray *comments) { self.comments = comments; }];
}

- (void)setCommit:(Commit *)commit
{
    if (_comments) { commit.comments = _comments; }
    _commit = commit;
    [self refresh];
}

- (void)setComments:(NSArray *)comments
{
    if (_commit) { _commit.comments = comments; }
    _comments = comments;

    self.commentWebViews = [[NSMutableArray alloc] initWithCapacity:comments.count];

    for (Comment *comment in comments) {
        UIWebView *commentWebView = [UIWebView new];
        commentWebView.delegate = self;
        [commentWebView loadHTMLString:comment.parsedBody baseURL:nil];
        [self.commentWebViews addObject:commentWebView];
    }

    [self refresh];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self refresh];
}

- (void)refresh
{
    if (self.commit && self.commit.comments) {
        [self hideCommit];
        [self displayCommit];
    }
}

- (void)displayCommit
{
    UIView *previous = nil;

    for (File *file in self.commit.files) {
        CGFloat originY = previous ? previous.frame.origin.y + previous.frame.size.height + FILE_MARGIN : FILE_MARGIN;
        CGRect fileViewFrame = CGRectMake(FILE_MARGIN, originY, self.frame.size.width - (FILE_MARGIN * 2), 0);
        FileView *fileView = [[FileView alloc] initWithFrame:fileViewFrame];
        fileView.file = file;
        [self.scrollView addSubview:fileView];
        previous = fileView;
    }

    if(self.commit.comments) {
        CGFloat originY = previous ? previous.frame.origin.y + previous.frame.size.height + FILE_MARGIN : FILE_MARGIN;
        CGRect commitLevelCommentThreadViewFrame = CGRectMake(FILE_MARGIN, originY, self.frame.size.width - (FILE_MARGIN * 2), 0);
        CommitLevelCommentThreadView *commitLevelCommentThreadView = [[CommitLevelCommentThreadView alloc] initWithFrame:commitLevelCommentThreadViewFrame];
        commitLevelCommentThreadView.comments = self.commit.comments;
        [self.scrollView addSubview:commitLevelCommentThreadView];
        previous = commitLevelCommentThreadView;
    }

    CGFloat originY = previous ? previous.frame.origin.y + previous.frame.size.height + FILE_MARGIN : 0;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, originY);
    [self addSubview:self.scrollView];
}

- (void)hideCommit
{
    for (UIView *view in self.scrollView.subviews) { [view removeFromSuperview]; }
}

@end
