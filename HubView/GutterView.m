#import "GutterView.h"

@implementation GutterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:245.0/255.0 blue:248.0/255.0 alpha:1];
        self.layer.borderColor = [UIColor colorWithRed:182.0/255.0 green:187.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

@end
