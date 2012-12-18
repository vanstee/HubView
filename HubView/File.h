#import <Foundation/Foundation.h>
#import "Commit.h"

@class Commit;

@interface File : NSObject

@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *patch;
@property (nonatomic, strong) Commit *commit;

+ (File *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

@end
