#import "CommentLine.h"

@implementation CommentLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    CommentLine *line = [CommentLine new];
    line.rawLine = rawLine;
    return line;
}

- (NSNumber *)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (NSNumber *)progressAfterLineNumber
{
    return self.afterLineNumber;
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"|     |     | %@", self.rawLine];
}

@end
