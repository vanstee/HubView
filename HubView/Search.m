#import "Search.h"

#import "GitHubClient.h"
#import "User.h"

@implementation Search

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.keyword = attributes[@"keyword"];
    }
    return self;
}

- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/legacy/user/search/%@", self.keyword] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *users = [User initWithArrayOfDictionaries:responseObject[@"users"]];
        if (block) { block(users); }
    } failure:nil];
}

@end
