#import "NSDate+Formatting.h"

@implementation NSDate (Formatting)

+ (NSDate *)parseDate:(NSString *)dateString
{
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    return [dateFormatter dateFromString:dateString];
}

- (NSString *)distanceOfTimeInWords
{
    double seconds = [self timeIntervalSinceNow] * -1;

    NSUInteger difference = 0;
    BOOL pluralize = NO;
    NSString *unit = @"";

    if (seconds < MINUTE) {
        return @"just now";
    } else if (seconds < HOUR) {
        difference = round(seconds / MINUTE);
        unit = @"minute";
    } else if (seconds < DAY) {
        difference = round(seconds / MINUTE);
        unit = @"hour";
    } else if (seconds < WEEK) {
        difference = round(seconds / DAY);
        unit = @"day";
    } else if (seconds < MONTH) {
        difference = round(seconds / WEEK);
        unit = @"week";
    } else if (seconds < YEAR) {
        difference = round(seconds / MONTH);
        unit = @"month";
    } else {
        difference = round(seconds / YEAR);
        unit = @"year";
    }

    if (difference > 1) { pluralize = YES; }

    return [NSString stringWithFormat:@"%d %@%@ ago", difference, unit, (pluralize ? @"s" : @"")];
}

@end