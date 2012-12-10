#import <Foundation/Foundation.h>

#import "AFJSONRequestOperation.h"
#import "AFGitHubClient.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *login;

+ (User *)userFromDictionary:(NSDictionary *)attributes;

+ (NSArray *)usersFromArray:(NSArray *)attributesArray;

+ (void)searchUsers:(NSString *)keyword withCompletionBlock:(void (^)(NSArray *users))block;

@end
