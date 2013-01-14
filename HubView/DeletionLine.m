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
    return [UIColor deletionLineBackgroundColor];
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
