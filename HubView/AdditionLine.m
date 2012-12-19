#import "AdditionLine.h"

@implementation AdditionLine

- (NSNumber *)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:221.0/255.0 green:255.0/255.0 blue:221.0/255.0 alpha:1];
}

@end
