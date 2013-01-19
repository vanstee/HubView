#import <UIKit/UIKit.h>

#define COMMENT_MARGIN 10

@class Comment;
@class CommentThreadView;
@class CommitLevelCommentThreadView;

@interface CommentView : UIView

@property (nonatomic, strong) Comment *comment;
@property (nonatomic, weak) CommentThreadView *commentThreadView;
@property (nonatomic, weak) CommitLevelCommentThreadView *commitLevelCommentThreadView;

@end
