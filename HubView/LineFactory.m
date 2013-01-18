#import "LineFactory.h"

#import "Line.h"
#import "AdditionLine.h"
#import "CommentLine.h"
#import "ContextLine.h"
#import "DeletionLine.h"
#import "RangeLine.h"

@implementation LineFactory

+ (id)createLineWithRawLine:(NSString *)rawLine
{
    return [[[LineFactory lineTypeForRawLine:rawLine] alloc] initWithRawLine:rawLine];
}

+ (id)createLineWithRawLine:(NSString *)rawLine andPreviousLine:(Line *)previousLine
{
    id line = [LineFactory createLineWithRawLine:rawLine];
    [line setBeforeLineNumber:[previousLine progressBeforeLineNumber]];
    [line setAfterLineNumber:[previousLine progressAfterLineNumber]];
    return line;
}

+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines
{
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:rawLines.count];
    Line *previousLine;
    
    for (NSString *rawLine in rawLines) {
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
