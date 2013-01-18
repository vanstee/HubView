#import "PanelView.h"

#import "PanelNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation PanelView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;

        CGRect navigationBarFrame = CGRectMake(0, 0, self.frame.size.width, PANEL_NAVIGATION_BAR_HEIGHT);
        self.navigationBar = [[PanelNavigationBar alloc] initWithFrame:navigationBarFrame];
        [self addSubview:self.navigationBar];
    }

    return self;
}

- (void)setTitle:(NSString *)title
{
    self.navigationBar.title = title;
}

@end
