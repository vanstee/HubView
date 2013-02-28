#import "PanelView.h"

@class CommitView;

@interface CommitLevelCommentThreadView : PanelView <UITextViewDelegate>

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, weak) CommitView *commitView;

@end
