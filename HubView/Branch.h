#import <Foundation/Foundation.h>
#import "Commit.h"
#import "GitHubClient.h"
#import "Repository.h"

@class Repository;

@interface Branch : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Repository *repository;

+ (Branch *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (void)commitsWithCompletionBlock:(void (^)(NSArray *commits))block;

@end