#import "CommentThreadView.h"

#import "CommentView.h"
#import "CommitViewController.h"
#import "FileContentView.h"
#import "FileView.h"
#import "GutterView.h"
#import "Line.h"
#import "PrettyButton.h"

@implementation CommentThreadView

- (void)setComments:(NSArray *)comments
{
    CGFloat position = 0;
    CGFloat width = self.fileContentView.fileView.frame.size.width - GUTTER_WIDTH;

    for (Comment *comment in comments) {
        CGRect commentViewFrame = CGRectMake(COMMENT_THREAD_MARGIN, position + COMMENT_THREAD_MARGIN, width - (COMMENT_THREAD_MARGIN * 2), 0);
        CommentView *commentView = [[CommentView alloc] initWithFrame:commentViewFrame];
        commentView.commentThreadView = self;
        commentView.comment = comment;

        [self addSubview:commentView];

        position += commentView.frame.size.height + COMMENT_THREAD_MARGIN;
    }

    UIButton *replyButton = [[PrettyButton alloc] initWithFrame:CGRectMake(0, 0, 54, 30)];
    [replyButton setTitle:@"Reply" forState:UIControlStateNormal];
    CGPoint replyButtonPoint = CGPointMake(width - COMMENT_THREAD_MARGIN - replyButton.frame.size.width, position + COMMENT_THREAD_MARGIN);
    replyButton.frame = CGRectMake(replyButtonPoint.x, replyButtonPoint.y, replyButton.frame.size.width, replyButton.frame.size.height);

    [replyButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:replyButton];
    position += replyButton.frame.size.height + COMMENT_THREAD_MARGIN;

    CGRect frame = self.frame;
    frame.size.height += position + COMMENT_THREAD_MARGIN;
    self.frame = frame;
}

- (void)touchButton:(id)sender
{
    [[self commitViewController] displayCommentFormForButton:sender line:self.line];
}

- (CommitViewController *)commitViewController
{
    id responder = [self nextResponder];

    while (responder) {
        if ([responder isKindOfClass:[UIView class]]) {
            responder = [responder nextResponder];
        } else if ([responder isKindOfClass:[UIViewController class]]) {
            return responder;
        }
    }

    return responder;
}

@end
