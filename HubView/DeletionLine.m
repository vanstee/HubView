#import "DeletionLine.h"

@implementation DeletionLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    DeletionLine *line = [DeletionLine new];
    line.rawLine = rawLine;
    return line;
}

- (NSNumber *)progressAfterLineNumber
{
    return self.afterLineNumber;
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"| %3d |     | %@", [self.beforeLineNumber integerValue], self.rawLine];
}

@end
