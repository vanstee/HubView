#import "DeletionLine.h"

@implementation DeletionLine

- (NSNumber *)progressAfterLineNumber
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

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"| %3d |     | %@", self.beforeLineNumber.integerValue, self.rawLine];
}

@end
