#import "PanelView.h"

#define FILE_MARGIN 20

@class CommitView;
@class File;

@interface FileView : PanelView

@property (nonatomic, strong) File *file;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) CommitView *commitView;

- (id)initWithFrame:(CGRect)frame;

@end
