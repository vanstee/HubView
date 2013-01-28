#import "Patch.h"

#import "Line.h"
#import "LineNumberView.h"
#import "LineFactory.h"

@implementation Patch

- (id)initWithRawPatch:(NSString *)rawPatch
{
    self = [super init];
    if (self) {
        NSArray *lines = [LineFactory createLinesWithRawLines:[rawPatch componentsSeparatedByString:@"\n"]];

        for (Line *line in lines) {
            line.patch = self;
        }

        self.lines = lines;
    }
    return self;
}

- (NSInteger)maxLineWidth
{
    NSInteger max = 0;
    for (Line *line in self.lines) {
        NSString *rawLine = [NSString stringWithFormat:@" %@", line.rawLine];
        max = MAX(max, [rawLine sizeWithFont:[UIFont fontWithName:@"Menlo" size:12]].width + LINE_NUMBER_VIEW_WIDTH);
    }
    return max;
}

@end