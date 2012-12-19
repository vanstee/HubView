#import "Line.h"

@implementation Line

- (id)initWithRawLine:(NSString *)rawLine
{
    self = [super init];
    if (self) {
        self.rawLine = rawLine;
    }
    return self;
}

- (NSNumber *)progressBeforeLineNumber
{
    return @(self.beforeLineNumber.integerValue + 1);
}

- (NSNumber *)progressAfterLineNumber
{
    return @(self.afterLineNumber.integerValue + 1);
}

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:255.0/255.0 alpha:1];
}

@end
