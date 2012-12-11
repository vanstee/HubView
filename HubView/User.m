#import "User.h"

@implementation User

+ (User *)initWithDictionary:(NSDictionary *)attributes
{
    User *user = [User new];
    user.login = [attributes objectForKey:@"login"];
    return user;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [users addObject:[self initWithDictionary:attributes]];
    }
    return users;
}

- (void)repositoriesWithCompletionBlock:(void (^)(NSArray *repositories))block
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/users/%@/repos", self.login] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *repositories = [Repository initWithArrayOfDictionaries:responseObject];
        for (Repository *repository in repositories) { repository.owner = self; }
        if (block) { block(repositories); }
    } failure:nil];
}

@end