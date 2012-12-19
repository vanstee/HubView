#import "CommentLine.h"

@implementation CommentLine

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
