#import "Patch.h"

@implementation Patch

+ (Patch *)initWithRawPatch:(NSString *)rawPatch
{
    Patch *patch = [Patch new];
    patch.lines = [LineFactory createLinesWithRawLines:[rawPatch componentsSeparatedByString:@"\n"]];
    return patch;
}

@end