#import "PanelView.h"

@class CommitView;

@interface CommitLevelCommentThreadView : PanelView

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, weak) CommitView *commitView;

@end
