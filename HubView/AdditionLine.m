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
    return [UIColor additionLineBackgroundColor];
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
