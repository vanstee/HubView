#import "Repository.h"

#import "Branch.h"
#import "GitHubClient.h"
#import "User.h"

@implementation Repository

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [repositories addObject:[[Repository alloc] initWithDictionary:attributes]];
    }
    return repositories;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.defaultBranch = attributes[@"default_branch"];
        self.updatedAt = [NSDate parseDate:attributes[@"updated_at"]];
        self.owner = [[User alloc] initWithDictionary:attributes[@"owner"]];
    }
    return self;
}

- (NSString *)defaultBranch
{
    return _defaultBranch ?: @"master";
}

- (void)branchesWithCompletionBlock:(void (^)(NSArray *branches))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/branches", self.owner.login, self.name] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *branches = [Branch initWithArrayOfDictionaries:responseObject];
        for (Branch *branch in branches) { branch.repository = self; }
        branches = [branches sortedArrayUsingComparator:^NSComparisonResult(Branch *a, Branch *b) {
            if ([a.name isEqualToString:a.repository.defaultBranch]) { return NSOrderedAscending; }
            if ([b.name isEqualToString:b.repository.defaultBranch]) { return NSOrderedDescending; }
            return [[a.name lowercaseString] compare:[b.name lowercaseString]];
        }];
        if (block) { block(branches); }
    } failure:nil];
}

@end
