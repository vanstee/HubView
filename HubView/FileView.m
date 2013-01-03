#import "FileView.h"

@implementation FileView

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height file:(File *)file;
{
    self = [super initWithContainerFrame:containerFrame originY:originY height:height title:file.filename];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    return self;
}

@end
