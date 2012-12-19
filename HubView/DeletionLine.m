#import "DeletionLine.h"

@implementation DeletionLine

- (NSNumber *)progressAfterLineNumber
{
    return self.afterLineNumber;
}

- (NSString *)formattedLine
{
    return [NSString stringWithFormat:@"| %3d |     | %@", self.beforeLineNumber.integerValue, self.rawLine];
}

@end
