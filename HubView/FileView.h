#import "File.h"
#import "FileContentView.h"
#import "GutterView.h"
#import "LineNumberLabel.h"
#import "PanelView.h"

#define FILE_MARGIN 20

@interface FileView : PanelView

@property (nonatomic, strong) File *file;
@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame;

@end
