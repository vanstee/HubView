#import <Foundation/Foundation.h>
#import "Commit.h"
#import "File.h"
#import "GitHubClient.h"
#import "GitUser.h"
#import "Repository.h"
#import "User.h"

@class Repository;
@class User;

@interface Commit : NSObject

@property (nonatomic, strong) NSString *sha;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) GitUser *gitAuthor;
@property (nonatomic, strong) GitUser *gitCommitter;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) User *committer;
@property (nonatomic, strong) Repository *repository;
@property (nonatomic, strong) NSArray *files;

+ (Commit *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (NSString *)detail;

- (void)commitWithCompletionBlock:(void (^)(Commit *commit))block;

@end
