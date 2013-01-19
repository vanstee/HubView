#import <UIKit/UIKit.h>

#define COMMENT_THREAD_MARGIN 10

@class FileContentView;

@interface CommentThreadView : UIView

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, weak) FileContentView *fileContentView;

@end