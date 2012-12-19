#import "AdditionLine.h"

@implementation AdditionLine

- (NSNumber *)progressBeforeLineNumber
{
    return self.beforeLineNumber;
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"|     | %3d | %@", self.afterLineNumber.integerValue, self.rawLine];
}

@end
