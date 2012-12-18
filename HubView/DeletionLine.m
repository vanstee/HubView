#import "DeletionLine.h"

@implementation DeletionLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    DeletionLine *line = [DeletionLine new];
    line.rawLine = rawLine;
    return line;
}

@end
