#import <Foundation/Foundation.h>

#import "AFGitHubClient.h"
#import "User.h"

@interface Search : NSObject

@property (nonatomic, strong) NSString *keyword;

+ (Search *)initWithDictionary:(NSDictionary *)attributes;

- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block;

@end
