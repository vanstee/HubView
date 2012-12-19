#import "DeletionLine.h"

@implementation DeletionLine

- (NSInteger)progressAfterLineNumber
{
    return self.afterLineNumber;
}

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:255.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
}

- (NSString *)beforeLineNumberString
{
    return [NSString stringWithFormat:@"%3d", self.beforeLineNumber];
}

- (NSString *)afterLineNumberString
{
    return @"";
}

@end
