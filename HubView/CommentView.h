#import <UIKit/UIKit.h>
#import "Comment.h"

#define COMMENT_MARGIN 10

@class Comment;

@interface CommentView : UIView

@property (nonatomic, strong) Comment *comment;

@property NSArray *comments;

@end
