#import "CommentThreadView.h"

#import "CommentView.h"

@implementation CommentThreadView

- (void)setComments:(NSArray *)comments
{
    CGFloat position = 0;

    for (Comment *comment in comments) {
        CGRect commentViewFrame = CGRectMake(COMMENT_THREAD_MARGIN, position + COMMENT_THREAD_MARGIN, self.frame.size.width - (COMMENT_THREAD_MARGIN * 2), 0);
        CommentView *commentView = [[CommentView alloc] initWithFrame:commentViewFrame];
        commentView.commentThreadView = self;
        commentView.comment = comment;
        
        [self addSubview:commentView];
        
        position += commentView.frame.size.height + COMMENT_THREAD_MARGIN;
    }

    CGRect frame = self.frame;
    frame.size.height += position + COMMENT_THREAD_MARGIN;
    self.frame = frame;
}
@end
