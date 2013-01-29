#import <UIKit/UIKit.h>

#define COMMENT_THREAD_MARGIN 10

@class FileContentView;
@class Line;

@interface CommentThreadView : UIView

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, weak) Line *line;
@property (nonatomic, weak) FileContentView *fileContentView;

@end