#import <Foundation/Foundation.h>

@class Commit;
@class GitUser;
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
@property (nonatomic, strong) NSArray *comments;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
- (id)initWithDictionary:(NSDictionary *)attributes;
- (NSString *)detail;
- (void)commitWithCompletionBlock:(void (^)(Commit *commit))block;
- (void)commentsWithCompletionBlock:(void (^)(NSArray *comments))block;

@end
