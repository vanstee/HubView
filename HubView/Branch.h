#import <Foundation/Foundation.h>

#import "Repository.h"
#import "User.h"

@interface Branch : NSObject

@property (nonatomic, strong) NSString *name;

+ (Branch *)branchFromDictionary:(NSDictionary *)attributes;

+ (NSArray *)branchesFromArray:(NSArray *)attributesArray;

+ (void)findBranchesForRepository:(Repository *)repository ownedBy:(User *)user withCompletionBlock:(void (^)(NSArray *branches))block;

@end
