#import "Branch.h"

#import "Commit.h"
#import "GitHubClient.h"
#import "Repository.h"
#import "User.h"

@implementation Branch

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *branches = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [branches addObject:[[Branch alloc] initWithDictionary:attributes]];
    }
    return branches;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.repository = attributes[@"repository"];
    }
    return self;
}

- (void)commitsWithCompletionBlock:(void (^)(NSArray *commits))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/commits", self.repository.owner.login, self.repository.name] parameters:@{@"sha" : self.name} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *commits = [Commit initWithArrayOfDictionaries:responseObject];
        for (Commit *commit in commits) { commit.repository = self.repository; }
        if (block) { block(commits); }
    } failure:nil];
}

@end
