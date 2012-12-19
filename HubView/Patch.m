#import "Patch.h"

@implementation Patch

- (id)initWithRawPatch:(NSString *)rawPatch
{
    self = [super init];
    if (self) {
        self.lines = [LineFactory createLinesWithRawLines:[rawPatch componentsSeparatedByString:@"\n"]];
    }
    return self;
}

@end