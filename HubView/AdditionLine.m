#import "AdditionLine.h"

@implementation AdditionLine

- (NSInteger)progressBeforeLineNumber
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

- (NSString *)beforeLineNumberString
{
    return @"";
}

- (NSString *)afterLineNumberString
{
    return [NSString stringWithFormat:@"%3d", self.afterLineNumber];
}

@end
