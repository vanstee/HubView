#import "RangeLine.h"

@implementation RangeLine

+ (NSDictionary *)parseRangeLine:(NSString *)rangeLine
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];

    NSString *rangeRegex = @"@@ -(\\d+)(,(\\d+))? \\+(\\d+)(,(\\d+))? @@";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:rangeRegex options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:rangeLine options:0 range:NSMakeRange(0, rangeLine.length)];
    
    for (int index = 1; index < match.numberOfRanges; index++) {
        NSRange range = [match rangeAtIndex:index];

        if (NSEqualRanges(range, NSMakeRange(NSNotFound, 0))) { continue; }

        NSString *capture = [rangeLine substringWithRange:range];
        
        switch (index) {
            case 1: attributes[@"beforeStartingLineNumber"] = capture; break;
            case 3: attributes[@"beforeNumberOfLines"]      = capture; break;
            case 4: attributes[@"afterStartingLineNumber"]  = capture; break;
            case 6: attributes[@"afterNumberOfLines"]       = capture; break;
            default: break;
        }
    }
    
    return attributes;
}

- (id)initWithRawLine:(NSString *)rawLine
{
    self = [super initWithRawLine:rawLine];
    if (self) {
        NSDictionary *rangeAttributes = [RangeLine parseRangeLine:rawLine];
        self.beforeStartingLineNumber = [rangeAttributes[@"beforeStartingLineNumber"] integerValue];
        self.beforeNumberOfLines      = [rangeAttributes[@"beforeNumberOfLines"] integerValue];
        self.afterStartingLineNumber  = [rangeAttributes[@"afterStartingLineNumber"] integerValue];
        self.afterNumberOfLines       = [rangeAttributes[@"afterNumberOfLines"] integerValue];
    }
    return self;
}

- (NSInteger)progressBeforeLineNumber
{
    return self.beforeStartingLineNumber;
}

- (NSInteger)progressAfterLineNumber
{
    return self.afterStartingLineNumber;
}

- (UIColor *)textColor
{
    return [UIColor grayColor];
}

- (UIColor *)backgroundColor
{
    return [UIColor rangeLineBackgroundColor];
}

- (NSString *)beforeLineNumberString
{
    return @"...";
}

- (NSString *)afterLineNumberString
{
    return @"...";
}

@end
