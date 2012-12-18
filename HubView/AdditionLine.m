#import "AdditionLine.h"

@implementation AdditionLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    AdditionLine *line = [AdditionLine new];
    line.rawLine = rawLine;
    return line;
}

- (NSNumber *)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"|     | %3d | %@", [self.afterLineNumber integerValue], self.rawLine];
}

@end
