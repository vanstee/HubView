#import "PanelView.h"

#define FILE_MARGIN 20

@class File;

@interface FileView : PanelView

@property (nonatomic, strong) File *file;
@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame;

@end
