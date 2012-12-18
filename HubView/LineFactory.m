#import "LineFactory.h"

@implementation LineFactory

+ (Line *)createLineWithRawLine:(NSString *)rawLine
{
    return [[self lineTypeForRawLine:rawLine] initWithRawLine:rawLine];
}

+ (Line *)createLineWithRawLine:(NSString *)rawLine andPreviousLine:(Line *)previousLine
{
    Line *line = [self createLineWithRawLine:rawLine];
    [line setBeforeLineNumber:[previousLine progressBeforeLineNumber]];
    [line setAfterLineNumber:[previousLine progressAfterLineNumber]];
    return line;
}

+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines
{
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:rawLines.count];
    Line *previousLine;
    
    for (int index = 0; index < rawLines.count; index++) {
        NSString *rawLine = rawLines[index];

        Line *line;
        if (previousLine) {
            line = [self createLineWithRawLine:rawLine andPreviousLine:previousLine];
        } else {
            line = [self createLineWithRawLine:rawLine];
        }

        previousLine = line;
        [lines addObject:line];
    }
    return lines;
}

+ (Class)lineTypeForRawLine:(NSString *)rawLine
{
    switch ([rawLine characterAtIndex:0]) {
        case '+':  return [AdditionLine class];
        case '-':  return [DeletionLine class];
        case '@':  return [RangeLine class];
        case '\\': return [CommentLine class];
        default:   return [ContextLine class];
    }
}

@end
