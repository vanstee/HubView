#import "PanelView.h"

@implementation PanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height
{
    CGRect frame = CGRectMake(PANEL_MARGIN, originY, containerFrame.size.width - (PANEL_MARGIN * 2), PANEL_HEADER_HEIGHT + height);
    return [self initWithFrame:frame];
}

@end
