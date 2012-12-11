#import "Search.h"

@implementation Search

+ (Search *)initWithDictionary:(NSDictionary *)attributes
{
    Search *search = [Search new];
    search.keyword = attributes[@"keyword"];
    return search;
}

- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/legacy/user/search/%@", self.keyword] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *users = [User initWithArrayOfDictionaries:[responseObject objectForKey:@"users"]];
        if (block) { block(users); }
    } failure:nil];
}

@end
