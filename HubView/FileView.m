#import "FileView.h"

@implementation FileView

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height file:(File *)file;
{
    if(self = [super initWithContainerFrame:containerFrame originY:originY height:height title:file.filename]) {
        CGRect frame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, self.frame.size.width, self.frame.size.height);
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
    }

    return self;
}

@end
