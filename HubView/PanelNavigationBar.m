#import "PanelNavigationBar.h"

@implementation PanelNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 3;
    }

    return self;
}

- (id)initWithTitle:(NSString *)title width:(CGFloat)width
{
    CGRect frame = CGRectMake(0, 0, width, PANEL_NAVIGATION_BAR_HEIGHT);

    if(self = [self initWithFrame:frame]) {
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
        [self pushNavigationItem:navigationItem animated:NO];
    }

    return self;
}

@end
