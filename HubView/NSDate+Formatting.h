#import <Foundation/Foundation.h>

@interface NSDate (Formatting)

+ (NSDateFormatter *)dateFormatter;

- (NSString *)distanceOfTimeInWords;

@end