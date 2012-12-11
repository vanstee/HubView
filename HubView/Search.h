#import <Foundation/Foundation.h>

#import "AppDelegate.h"

@interface Search : NSObject

@property (nonatomic, strong) NSString *keyword;

+ (Search *)initWithDictionary:(NSDictionary *)attributes;

- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block;

@end
