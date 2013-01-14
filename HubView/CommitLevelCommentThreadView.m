#import "CommitLevelCommentThreadView.h"

@implementation CommitLevelCommentThreadView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"Comments";
    }

    return self;
}

- (void)setComments:(NSArray *)comments
{
    CGFloat position = PANEL_NAVIGATION_BAR_HEIGHT;

    for (Comment *comment in comments) {
        CGRect commentViewFrame = CGRectMake(COMMENT_THREAD_MARGIN, position + COMMENT_THREAD_MARGIN, self.frame.size.width - (COMMENT_THREAD_MARGIN * 2), 0);
        CommentView *commentView = [[CommentView alloc] initWithFrame:commentViewFrame];
        commentView.comment = comment;

        [self addSubview:commentView];

        position += commentView.frame.size.height + COMMENT_THREAD_MARGIN;
    }

    CGRect frame = self.frame;
    frame.size.height += position + COMMENT_THREAD_MARGIN;
    self.frame = frame;
}

@end
