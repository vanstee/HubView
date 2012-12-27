#import "Commit.h"

@implementation Commit

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *commits = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [commits addObject:[[Commit alloc] initWithDictionary:attributes]];
    }
    return commits;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.sha = attributes[@"sha"];
        self.message = [attributes[@"commit"][@"message"] componentsSeparatedByString: @"\n"][0];
        self.gitAuthor = [[GitUser alloc] initWithDictionary:attributes[@"commit"][@"author"]];
        self.gitCommitter = [[GitUser alloc] initWithDictionary:attributes[@"commit"][@"committer"]];
        self.repository = attributes[@"repository"];
        if (attributes[@"author"] != [NSNull null]) { self.author = [[User alloc] initWithDictionary:attributes[@"author"]]; }
        if (attributes[@"committer"] != [NSNull null]) { self.committer = [[User alloc] initWithDictionary:attributes[@"committer"]]; }
        if (attributes[@"files"] != [NSNull null]) { self.files = [File initWithArrayOfDictionaries:attributes[@"files"]]; }
    }
    return self;
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

- (NSDictionary *)commentsByPathAndPosition
{
    NSMutableDictionary *comments = [NSMutableDictionary dictionaryWithCapacity:self.comments.count];
    for (Comment *comment in self.comments) {
        NSNumber *position = [NSNumber numberWithInteger:comment.position];
        if (!comments[comment.path]) { comments[comment.path] = [NSMutableDictionary new]; }
        if (!comments[comment.path][position]) { comments[comment.path][position] = [NSMutableArray new]; }
        [comments[comment.path][position] addObject:comment];
    }

    for (NSString *path in comments) {
        for (NSNumber *position in comments[path]) {
            NSArray *commentsForPathAndPosition = comments[path][position];
            comments[path][position] = [[[commentsForPathAndPosition sortedArrayUsingSelector:@selector(createdAt)] reverseObjectEnumerator] allObjects];
        }
    }

    return comments;
}

- (void)commitWithCompletionBlock:(void (^)(Commit *commit))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/commits/%@", self.repository.owner.login, self.repository.name, self.sha] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Commit *commit = [[Commit alloc] initWithDictionary:responseObject];
        commit.repository = self.repository;
        if (block) { block(commit); }
    } failure:nil];
}

- (void)commentsWithCompletionBlock:(void (^)(NSArray *comments))block
{
    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] getPath:[NSString stringWithFormat:@"/repos/%@/%@/commits/%@/comments", self.repository.owner.login, self.repository.name, self.sha] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *comments = [Comment initWithArrayOfDictionaries:responseObject];
        if (block) { block(comments); }
    } failure:nil];
}

@end
