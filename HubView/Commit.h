#import <Foundation/Foundation.h>

#import "AppDelegate.h"

@class Branch;
@class File;
@class User;

@interface Commit : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) NSArray *files;

+ (NSDate *)parseDate:(NSString *)date;

+ (Commit *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (NSString *)detail;

@end
