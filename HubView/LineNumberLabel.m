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

- (id)initWithText:(NSString *)text originY:(CGFloat)originY
{
    CGRect frame = CGRectMake(LINE_NUMBER_MARGIN, originY, LINE_NUMBER_WIDTH - (LINE_NUMBER_MARGIN * 2), LINE_HEIGHT);

    if ([text isEqualToString:@"..."]) {
        frame.origin.y = originY - (LINE_HEIGHT / 8.0);
    }

    if (self = [self initWithFrame:frame]) {
        self.text = text;
    }

    return self;
}

@end
