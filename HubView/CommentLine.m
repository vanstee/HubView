#import "CommentLine.h"

@implementation CommentLine

- (NSInteger)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (NSInteger)progressAfterLineNumber
{
    return self.afterLineNumber;
}

- (UIColor *)textColor
{
    return [UIColor grayColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:234.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
}

- (NSString *)beforeLineNumberString
{
    return @"";
}

- (NSString *)afterLineNumberString
{
    return @"";
}

@end
