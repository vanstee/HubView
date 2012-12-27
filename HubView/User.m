#import "User.h"

@implementation User

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [users addObject:[[User alloc] initWithDictionary:attributes]];
    }
    return users;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.login = attributes[@"login"];
    }
    return self;
}

- (void)repositoriesWithCompletionBlock:(void (^)(NSArray *repositories))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/users/%@/repos", self.login] parameters:@{@"per_page" : @"200"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *repositories = [Repository initWithArrayOfDictionaries:responseObject];
        for (Repository *repository in repositories) { repository.owner = self; }
        if (block) { block(repositories); }
    } failure:nil];
}

@end