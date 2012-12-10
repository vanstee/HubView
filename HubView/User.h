#import <Foundation/Foundation.h>

#import "AFJSONRequestOperation.h"
#import "AFGitHubClient.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *login;

+ (User *)userFromDictionary:(NSDictionary *)attributes;

+ (NSArray *)usersFromArray:(NSArray *)arrayOfAttributes;

+ (void)searchUsers:(NSString *)keyword success:(void (^)(NSArray *users))success;

@end
