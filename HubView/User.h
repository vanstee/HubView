#import <Foundation/Foundation.h>

#import "AFGitHubClient.h"
#import "Repository.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *login;

+ (User *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (void)repositoriesWithCompletionBlock:(void (^)(NSArray *repositories))block;

@end
