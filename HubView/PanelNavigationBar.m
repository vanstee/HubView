#import "PanelNavigationBar.h"

#import <QuartzCore/QuartzCore.h>

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

- (void)setTitle:(NSString *)title
{
    [self popNavigationItemAnimated:NO];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
    [self pushNavigationItem:navigationItem animated:NO];
}

@end
