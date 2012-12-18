#import "Commit.h"

@implementation Commit

+ (Commit *)initWithDictionary:(NSDictionary *)attributes
{
    Commit *commit = [Commit new];
    commit.sha = attributes[@"sha"];
    commit.message = [[attributes[@"commit"][@"message"] componentsSeparatedByString: @"\n"] objectAtIndex:0];
    commit.gitAuthor = [GitUser initWithDictionary:attributes[@"commit"][@"author"]];
    commit.gitCommitter = [GitUser initWithDictionary:attributes[@"commit"][@"committer"]];
    if (attributes[@"author"] != [NSNull null]) { commit.author = [User initWithDictionary:attributes[@"author"]]; }
    if (attributes[@"committer"] != [NSNull null]) { commit.committer = [User initWithDictionary:attributes[@"committer"]]; }
    commit.repository = attributes[@"repository"];
    if (attributes[@"files"] != [NSNull null]) { commit.files = [File initWithArrayOfDictionaries:attributes[@"files"]]; }
    return commit;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *commits = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [commits addObject:[self initWithDictionary:attributes]];
    }
    return commits;
}

- (NSDate *)date
{
    NSDate *date;

    for (NSString *attribute in @[@"gitAuthor", @"gitCommitter"]) {
        GitUser *gitUser = [self valueForKey:attribute];
        if (gitUser) {
            date = gitUser.date;
            break;
        }
    }

    return date;
}

- (NSString *)login
{
    NSString *login = @"Unknown";

    for (NSString *attribute in @[@"author", @"committer", @"gitAuthor", @"gitCommitter"]) {
        id user = [self valueForKey:attribute];
        if ([user respondsToSelector:@selector(login)]) {
            login = [user login];
            break;
        } else if ([user respondsToSelector:@selector(name)]) {
            login = [user name];
            break;
        }
    }

    return login;
}

- (NSString *)detail
{
    return [NSString stringWithFormat:@"%@ authored %@", self.login, self.date.distanceOfTimeInWords];
}

- (void)commitWithCompletionBlock:(void (^)(Commit *commit))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/commits/%@", self.repository.owner.login, self.repository.name, self.sha] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Commit *commit = [Commit initWithDictionary:responseObject];
        commit.repository = self.repository;
        if (block) { block(commit); }
    } failure:nil];
}

@end