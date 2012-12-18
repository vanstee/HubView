#import "Line.h"

@implementation Line

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    Line *line = [Line new];
    line.rawLine = rawLine;
    return line;
}

@end
