#import <Foundation/Foundation.h>

#define MINUTE 60
#define HOUR 3600
#define DAY 86400
#define WEEK 604800
#define MONTH 2592000
#define YEAR 31557600

@interface NSDate (Formatting)

+ (NSDate *)parseDate:(NSString *)dateString;
- (NSString *)distanceOfTimeInWords;

@end