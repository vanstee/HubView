#import "LineNumberLabel.h"

@implementation LineNumberLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.textColor = [UIColor lineNumberFontColor];
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:@"Menlo" size:10];
        self.textAlignment = NSTextAlignmentRight;
    }

    return self;
}

@end
