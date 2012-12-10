#import "Repository.h"

@implementation Repository

@synthesize name = _name;

+ (Repository *)repositoryFromDictionary:(NSDictionary *)attributes
{
    Repository *repository = [Repository new];
    repository.name = [attributes objectForKey:@"name"];
    return repository;
}

+ (NSArray *)repositoriesFromArray:(NSArray *)attributesArray
{
    NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[attributesArray count]];
    for (NSDictionary *attributes in attributesArray) {
        [repositories addObject:[self repositoryFromDictionary:attributes]];
    }
    return repositories;
}

+ (void)findRepositoriesForUser:(User *)user withCompletionBlock:(void (^)(NSArray *repositories))block
{
    [[[AFGitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[AFGitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/users/%@/repos", user.login] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseArray = (NSArray *)responseObject;
        NSArray *repositories = [self repositoriesFromArray:responseArray];
        if (block) { block(repositories); }
    } failure:nil];
}

@end
