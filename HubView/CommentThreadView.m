#import "CommentThreadView.h"

#import "CommentView.h"
#import "FileContentView.h"
#import "FileView.h"
#import "GutterView.h"

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

    CGRect frame = self.frame;
    frame.size.height += position + COMMENT_THREAD_MARGIN;
    self.frame = frame;
}
@end
