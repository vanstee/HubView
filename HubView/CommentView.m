#import "CommentView.h"

#import "Comment.h"
#import "CommentThreadView.h"
#import "CommitView.h"
#import "CommitLevelCommentThreadView.h"
#import "FileContentView.h"
#import "FileView.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommentView

- (void)setComment:(Comment *)comment
{
    NSInteger contentTextWidth = self.frame.size.width - (COMMENT_MARGIN * 2);
    UIFont *headerFont = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize headerTextSize = [comment.user.login sizeWithFont:headerFont constrainedToSize:CGSizeMake(contentTextWidth, 10000)];
    CGSize headerSize = CGSizeMake(self.frame.size.width, headerTextSize.height + (COMMENT_MARGIN * 2));

    CGRect headerFrame = CGRectMake(0, 0, self.frame.size.width, headerSize.height);
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.layer.borderColor = [UIColor commentBorderColor].CGColor;
    header.layer.borderWidth = 1;

    CAGradientLayer *gradient = [CAGradientLayer new];
    gradient.frame = header.bounds;
    gradient.colors = @[(id)[UIColor commentHeaderGradientStartColor].CGColor, (id)[UIColor commentHeaderGradientEndColor].CGColor];
    [header.layer insertSublayer:gradient atIndex:0];

    CGRect headerTextFrame = CGRectMake(COMMENT_MARGIN, COMMENT_MARGIN, contentTextWidth, headerTextSize.height);
    UILabel *headerText = [[UILabel alloc] initWithFrame:headerTextFrame];
    headerText.text = comment.user.login;
    headerText.font = headerFont;
    headerText.backgroundColor = [UIColor clearColor];
    headerText.lineBreakMode = NSLineBreakByWordWrapping;
    headerText.numberOfLines = 0;

    UILabel *headerDate = [[UILabel alloc] initWithFrame:headerTextFrame];
    headerDate.textAlignment = NSTextAlignmentRight;
    headerDate.text = comment.createdAt.distanceOfTimeInWords;
    headerDate.font = headerFont;
    headerDate.backgroundColor = [UIColor clearColor];
    headerDate.lineBreakMode = NSLineBreakByWordWrapping;
    headerDate.numberOfLines = 0;

    NSInteger index = [self.commitView.comments indexOfObject:comment];
    UIWebView *bodyWebView = self.commitView.commentWebViews[index];
    bodyWebView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    NSInteger height = [[bodyWebView stringByEvaluatingJavaScriptFromString:@"document.height"] integerValue];
    bodyWebView.frame = CGRectMake(0, 0, self.frame.size.width, height);

    CGRect bodyFrame = CGRectMake(0, headerSize.height - 1, self.frame.size.width, bodyWebView.frame.size.height);
    UIView *body = [[UIView alloc] initWithFrame:bodyFrame];
    body.backgroundColor = [UIColor commentBodyBackgroundColor];
    body.layer.borderColor = [UIColor commentBorderColor].CGColor;
    body.layer.borderWidth = 1;

    UIWebView *commentWebView = [[UIWebView alloc] initWithFrame:bodyWebView.frame];
    commentWebView.scrollView.bounces = NO;
    [commentWebView loadHTMLString:comment.parsedBody baseURL:nil];

    [header addSubview:headerText];
    [header addSubview:headerDate];
    [body addSubview:commentWebView];
    [self addSubview:header];
    [self addSubview:body];

    CGRect frame = self.frame;
    frame.size.height += headerFrame.size.height + bodyFrame.size.height;
    self.frame = frame;
}

- (CommitView *)commitView
{
    CommitView *commitView = nil;

    if (self.commentThreadView) {
        commitView = self.commentThreadView.fileContentView.fileView.commitView;
    } else if(self.commitLevelCommentThreadView) {
        commitView = self.commitLevelCommentThreadView.commitView;
    }

    return commitView;
}

@end
