#import "Line.h"

@implementation Line

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    Line *line = [Line new];
    line.rawLine = rawLine;
    return line;
}

- (NSNumber *)progressBeforeLineNumber
{
    return @([self.beforeLineNumber integerValue] + 1);
}

- (NSNumber *)progressAfterLineNumber
{
    return @([self.afterLineNumber integerValue] + 1);
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"| %3d | %3d | %@", [self.beforeLineNumber integerValue], [self.afterLineNumber integerValue], self.rawLine];
}

@end
