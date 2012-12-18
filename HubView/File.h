#import <Foundation/Foundation.h>
#import "Commit.h"
#import "Patch.h"

@class Commit;
@class Patch;

@interface File : NSObject

@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) Patch *patch;
@property (nonatomic, strong) Commit *commit;

+ (File *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

@end
