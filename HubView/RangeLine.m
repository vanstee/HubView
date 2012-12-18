#import "RangeLine.h"

@implementation RangeLine

+ (Line *)initWithRawLine:(NSString *)rawLine
{
    RangeLine *line = [RangeLine new];
    line.rawLine = rawLine;

    NSDictionary *rangeAttributes = [self parseRangeLine:rawLine];
    line.beforeStartingLineNumber = rangeAttributes[@"beforeStartingLineNumber"];
    line.beforeNumberOfLines = rangeAttributes[@"beforeNumberOfLines"];
    line.afterStartingLineNumber = rangeAttributes[@"afterStartingLineNumber"];
    line.afterNumberOfLines = rangeAttributes[@"afterNumberOfLines"];

    return line;
}

+ (NSDictionary *)parseRangeLine:(NSString *)rangeLine
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];

    NSString *rangeRegex = @"@@ -(\\d+),(\\d+) \\+(\\d+),(\\d+) @@";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:rangeRegex options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:rangeLine options:0 range:NSMakeRange(0, rangeLine.length)];

    for (int index = 1; index < match.numberOfRanges; index++) {
        NSString *capture = [rangeLine substringWithRange:[match rangeAtIndex:index]];

        switch (index) {
            case 1: attributes[@"beforeStartingLineNumber"] = capture; break;
            case 2: attributes[@"beforeNumberOfLines"]      = capture; break;
            case 3: attributes[@"afterStartingLineNumber"]  = capture; break;
            case 4: attributes[@"afterNumberOfLines"]       = capture; break;
            default: break;
        }
    }
    
    return attributes;
}

@end
