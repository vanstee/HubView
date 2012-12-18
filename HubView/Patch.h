#import <Foundation/Foundation.h>

#import "File.h"

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, strong) File *file;

+ (Patch *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;


@end