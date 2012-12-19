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

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"| %3d | %3d | %@", self.beforeLineNumber.integerValue, self.afterLineNumber.integerValue, self.rawLine];
}

@end
