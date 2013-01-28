#import "Comment.h"

#import "CommentBodyParser.h"
#import "Commit.h"
#import <GHMarkdownParser.h>
#import "GitHubClient.h"
#import "Repository.h"
#import "User.h"

@implementation Comment

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [comments addObject:[[Comment alloc] initWithDictionary:attributes]];
    }
    return comments;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.body = attributes[@"body"];
        self.user = [[User alloc] initWithDictionary:attributes[@"user"]];
        self.createdAt = [NSDate parseDate:attributes[@"created_at"]];
        if (attributes[@"line"] != [NSNull null]) { self.line = [attributes[@"line"] integerValue]; }
        if (attributes[@"position"] != [NSNull null]) { self.position = [attributes[@"position"] integerValue]; }
        if (attributes[@"path"] != [NSNull null]) { self.path = attributes[@"path"]; }

        self.commit = attributes[@"commit"];
    }
    return self;
}

- (NSString *)parsedBody
{
    return [CommentBodyParser htmlForMarkdownString:self.body];
}

- (NSDictionary *)attributes
{
    return @{
        @"body": self.body,
        @"line": @(self.line),
        @"path": self.path,
        @"position": @(self.position)
    };
}

+ (void)submitComment:(Comment *)comment completionBlock:(void (^)(bool))block
{
    NSString *path = [NSString stringWithFormat:@"/repos/%@/%@/commits/%@/comments",
                      comment.commit.repository.owner.login,
                      comment.commit.repository.name,
                      comment.commit.sha];

    [[[GitHubClient sharedClient] operationQueue] cancelAllOperations];
    [[GitHubClient sharedClient] postPath:path parameters:[comment attributes] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) { block(YES); }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) { block(NO); }
    }];
}

@end