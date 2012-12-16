#import <Foundation/Foundation.h>

#import "AFGitHubClient.h"
#import "Branch.h"
#import "User.h"

@class User;

@interface Repository : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) User *owner;

+ (Repository *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (void)branchesWithCompletionBlock:(void (^)(NSArray *branches))block;

@end