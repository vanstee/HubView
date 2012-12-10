#import <Foundation/Foundation.h>

#import "User.h"

@interface Repository : NSObject

@property (nonatomic, strong) NSString *name;

+ (Repository *)repositoryFromDictionary:(NSDictionary *)attributes;

+ (NSArray *)repositoriesFromArray:(NSArray *)attributesArray;

+ (void)findRepositoriesForUser:(User *)user withCompletionBlock:(void (^)(NSArray *repositories))block;

@end
