#import "Branch.h"

@implementation Branch

+ (Branch *)initWithDictionary:(NSDictionary *)attributes
{
    Branch *branch = [Branch new];
    branch.name = [attributes objectForKey:@"name"];
    branch.repository = [attributes objectForKey:@"repository"];
    return branch;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *branches = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [branches addObject:[self initWithDictionary:attributes]];
    }
    return branches;
}

- (void)commitsWithCompletionBlock:(void (^)(NSArray *commits))block
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/commits", self.repository.owner.login, self.repository.name] parameters:@{@"sha" : self.name} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *commits = [Commit initWithArrayOfDictionaries:responseObject];
        for (Commit *commit in commits) { commit.repository = (Repository *)self.repository; }
        if (block) { block(commits); }
    } failure:nil];
}

@end
