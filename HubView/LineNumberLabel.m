#import "LineNumberLabel.h"

@implementation LineNumberLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.textColor = [UIColor colorWithRed:172.0/255.0 green:177.0/255.0 blue:194.0/255.0 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:@"Menlo" size:10];
        self.textAlignment = NSTextAlignmentRight;
    }

    return self;
}

@end
