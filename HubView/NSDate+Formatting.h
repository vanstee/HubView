#import <Foundation/Foundation.h>

@interface NSDate (Formatting)

+ (NSDate *)parseDate:(NSString *)dateString;

- (NSString *)distanceOfTimeInWords;

@end