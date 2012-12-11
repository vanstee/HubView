#import "NSDate+Formatting.h"

@implementation NSDate (Formatting)

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

- (NSString *)distanceOfTimeInWords
{
    double seconds = [self timeIntervalSinceNow];
    seconds = seconds * -1;

    if (seconds < 60) {
        return @"just now";
    } else {
        NSUInteger difference = 0;
        BOOL pluralize = NO;
        NSString* unit = @"";
        
        if (seconds < 3600) {
            difference = round(seconds / 60);
            unit = @"minute";
        } else if (seconds < 86400) {
            difference = round(seconds / 3600);
            unit = @"hour";
        } else if (seconds < 604800) {
            difference = round(seconds / 86400);
            unit = @"day";
        } else if (seconds < 2592000) {
            difference = round(seconds / 604800);
            unit = @"week";
        } else if (seconds < 31557600) {
            difference = round(seconds / 2592000);
            unit = @"month";
        } else {
            difference = round(seconds / 2592000);
            unit = @"year";
        }
        
        if (difference > 1) {
            pluralize = YES;
        }
        
        return [NSString stringWithFormat:@"%d %@%@ ago", difference, unit, (pluralize ? @"s" : @"")];
    }
}

@end