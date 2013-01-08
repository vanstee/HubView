#import "LineLabel.h"

@implementation LineLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.font = [UIFont fontWithName:@"Menlo" size:12];
    }

    return self;
}

- (id)initWithLine:(Line *)line originY:(CGFloat)originY width:(CGFloat)width
{
    CGRect frame = CGRectMake(LINE_NUMBER_VIEW_WIDTH, originY, width, LINE_HEIGHT);

    if(self = [self initWithFrame:frame]) {
        self.text = [NSString stringWithFormat:@" %@", line.rawLine];
        self.textColor = line.textColor;
        self.backgroundColor = line.backgroundColor;
    }

    return self;
}

@end