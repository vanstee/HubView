#import "File.h"
#import "PanelView.h"

@interface FileView : PanelView

@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height file:(File *)file;

@end
