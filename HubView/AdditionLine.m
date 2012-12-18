#import "AdditionLine.h"

@implementation AdditionLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    AdditionLine *line = [AdditionLine new];
    line.rawLine = rawLine;
    return line;
}

@end
