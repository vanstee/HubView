#import "Repository.h"

@implementation Repository

+ (Repository *)initWithDictionary:(NSDictionary *)attributes
{
    Repository *repository = [Repository new];
    repository.name = attributes[@"name"];
    repository.updatedAt = [NSDate parseDate:attributes[@"updated_at"]];
    repository.owner = [User initWithDictionary:attributes[@"owner"]];
    return repository;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [repositories addObject:[self initWithDictionary:attributes]];
    }
    return repositories;
}

- (void)branchesWithCompletionBlock:(void (^)(NSArray *branches))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/branches", self.owner.login, self.name] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *branches = [Branch initWithArrayOfDictionaries:responseObject];
        for (Branch *branch in branches) { branch.repository = self; }
        if (block) { block(branches); }
    } failure:nil];
}

@end
