#import "CommentLine.h"

@implementation CommentLine

- (NSNumber *)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (NSNumber *)progressAfterLineNumber
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

@end
