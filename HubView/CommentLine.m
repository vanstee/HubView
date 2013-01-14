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
    return [UIColor commentLineBackgroundColor];
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
