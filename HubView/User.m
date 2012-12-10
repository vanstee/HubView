#import "User.h"


@implementation User

@synthesize login = _login;

+ (User *)userFromDictionary:(NSDictionary *)attributes
{
    User *user = [User new];
    user.login = [attributes objectForKey:@"login"];
    return user;
}

+ (NSArray *)usersFromArray:(NSArray *)attributesArray
{
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:[attributesArray count]];
    for (NSDictionary *attributes in attributesArray) {
        [users addObject:[self userFromDictionary:attributes]];
    }
    return users;
}

+ (void)searchUsers:(NSString *)keyword success:(void (^)(NSArray *users))success
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/legacy/user/search/%@", keyword] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSArray *users = [self usersFromArray:[responseDictionary objectForKey:@"users"]];
        success(users);
    } failure:nil];
}

@end
