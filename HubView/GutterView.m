#import "GutterView.h"

@implementation GutterView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:245.0/255.0 blue:248.0/255.0 alpha:1];
        self.layer.borderColor = [UIColor colorWithRed:182.0/255.0 green:187.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1;
    }

    return self;
}

- (id)initWithLines:(NSArray *)lines frame:(CGRect)frame type:(NSString *)type
{
    if(self = [super initWithFrame:frame]) {
        self.type = type;
        self.lines = lines;
    }

    return self;
}

@end
