#import "CommitLevelCommentThreadView.h"

#import "Comment.h"
#import "CommentView.h"
#import "CommentThreadView.h"
#import "CommitView.h"
#import "GitHubCredentials.h"
#import "PanelNavigationBar.h"
#import "PrettyButton.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommitLevelCommentThreadView {
    UITextView *commentBody;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"Comments";
        self.backgroundColor = [UIColor commitMessageViewBackgroundColor];
    }

    return self;
}

- (void)setComments:(NSArray *)comments
{
    CGFloat position = PANEL_NAVIGATION_BAR_HEIGHT;

    for (Comment *comment in comments) {
        CGRect commentViewFrame = CGRectMake(COMMENT_THREAD_MARGIN, position + COMMENT_THREAD_MARGIN, self.frame.size.width - (COMMENT_THREAD_MARGIN * 2), 0);
        CommentView *commentView = [[CommentView alloc] initWithFrame:commentViewFrame];
        commentView.commitLevelCommentThreadView = self;
        commentView.comment = comment;

        [self addSubview:commentView];

        position += commentView.frame.size.height + COMMENT_THREAD_MARGIN;
    }
    
    CGRect commentBodyFrame = CGRectMake(COMMENT_THREAD_MARGIN, position + COMMENT_THREAD_MARGIN, self.frame.size.width - (COMMENT_THREAD_MARGIN * 2), 200);
    commentBody = [[UITextView alloc] initWithFrame:commentBodyFrame];
    commentBody.font = [UIFont fontWithName:@"Helvetica" size:14];
    commentBody.layer.borderColor = [UIColor commentBorderColor].CGColor;
    commentBody.layer.borderWidth = 1;
    
    [self addSubview:commentBody];
    position += commentBody.frame.size.height + COMMENT_THREAD_MARGIN;
    
    UIButton *submitButton = [[PrettyButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    CGPoint submitButtonPoint = CGPointMake(self.frame.size.width - COMMENT_THREAD_MARGIN - submitButton.frame.size.width, position + COMMENT_THREAD_MARGIN);
    submitButton.frame = CGRectMake(submitButtonPoint.x, submitButtonPoint.y, submitButton.frame.size.width, submitButton.frame.size.height);
    [submitButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:submitButton];
    position += submitButton.frame.size.height + COMMENT_THREAD_MARGIN;

    CGRect frame = self.frame;
    frame.size.height += position + COMMENT_THREAD_MARGIN;
    self.frame = frame;
}


- (void)touchButton:(id)sender
{
    Comment *comment = [[Comment alloc] initWithDictionary:@{
                            @"commit": self.commitView.commit,
                            @"body": commentBody.text
                        }];
    comment.createdAt = [NSDate date];
    comment.user = [[User alloc] initWithDictionary:@{@"login": [GitHubCredentials sharedCredentials].username}];
    
    [Comment submitComment:comment completionBlock:^(bool successful) {
        if (successful) {
            commentBody.text = @"";
            NSMutableArray *comments = [NSMutableArray arrayWithArray:self.commitView.comments];
            [comments addObject:comment];
            self.commitView.comments = comments;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There were problems submitting your comment. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

@end
