#import <Foundation/Foundation.h>
#import "GitHubClient.h"
#import "User.h"

@interface Search : NSObject

@property (nonatomic, strong) NSString *keyword;

- (id)initWithDictionary:(NSDictionary *)attributes;
- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block;

@end
