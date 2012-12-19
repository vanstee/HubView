#import "Repository.h"

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
        self.updatedAt = [NSDate parseDate:attributes[@"updated_at"]];
        self.owner = [[User alloc] initWithDictionary:attributes[@"owner"]];
    }
    return self;
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
