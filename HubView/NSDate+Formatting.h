#import <Foundation/Foundation.h>

#define MINUTE 60
#define HOUR (MINUTE * 60)
#define DAY (HOUR * 24)
#define WEEK (DAY * 7)
#define MONTH (DAY * 30)
#define YEAR (DAY * 365.25)

@interface NSDate (Formatting)

+ (NSDate *)parseDate:(NSString *)dateString;
- (NSString *)distanceOfTimeInWords;

@end