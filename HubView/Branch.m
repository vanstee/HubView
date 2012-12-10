#import "Branch.h"

@implementation Branch

@synthesize name = _name;

+ (Branch *)branchFromDictionary:(NSDictionary *)attributes
{
    Branch *branch = [Branch new];
    branch.name = [attributes objectForKey:@"name"];
    return branch;
}

+ (NSArray *)branchesFromArray:(NSArray *)attributesArray
{
    NSMutableArray *branches = [NSMutableArray arrayWithCapacity:[attributesArray count]];
    for (NSDictionary *attributes in attributesArray) {
        [branches addObject:[self branchFromDictionary:attributes]];
    }
    return branches;
}

+ (void)findBranchesForRepository:(Repository *)repository ownedBy:(User *)user withCompletionBlock:(void (^)(NSArray *branches))block
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/branches", user.login, repository.name] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseArray = (NSArray *)responseObject;
        NSArray *branches = [self branchesFromArray:responseArray];
        if (block) { block(branches); }
    } failure:nil];
}

@end
