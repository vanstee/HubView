#import "LineFactory.h"

@implementation LineFactory

+ (Line *)createLineWithRawLine:(NSString *)rawLine
{
    Line *line = [[self lineTypeForRawLine:rawLine] initWithRawLine:rawLine];
    return line;
}

+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines
{
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:[rawLines count]];
    for (NSString *rawLine in rawLines) {
        [lines addObject:[self createLineWithRawLine:rawLine]];
    }
    return lines;
}

+ (Class)lineTypeForRawLine:(NSString *)rawLine
{
    switch ([rawLine characterAtIndex:0]) {
        case '+': return [AdditionLine class];
        case '-': return [DeletionLine class];
        case '@': return [RangeLine class];
        default:  return [ContextLine class];
    }
}

@end
