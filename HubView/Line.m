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

- (NSInteger)progressBeforeLineNumber
{
    return self.beforeLineNumber + 1;
}

- (NSInteger)progressAfterLineNumber
{
    return self.afterLineNumber + 1;
}

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor lineBackgroundColor];
}

- (NSString *)beforeLineNumberString
{
    return [NSString stringWithFormat:@"%3d", self.beforeLineNumber];
}

- (NSString *)afterLineNumberString
{
    return [NSString stringWithFormat:@"%3d", self.afterLineNumber];
}

@end
