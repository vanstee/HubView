#import "ContextLine.h"

@implementation ContextLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    ContextLine *line = [ContextLine new];
    line.rawLine = rawLine;
    return line;
}

@end
