#import <Foundation/Foundation.h>

@class Commit;
@class Patch;

@interface File : NSObject

@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) Patch *patch;
@property (nonatomic, strong) NSDictionary *commentsByPosition;
@property (nonatomic, weak) Commit *commit;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
- (id)initWithDictionary:(NSDictionary *)attributes;

@end
