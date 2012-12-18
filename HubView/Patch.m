#import "Patch.h"

@implementation Patch

+ (File *)initWithDictionary:(NSDictionary *)attributes
{
    File *file = [File new];
    file.filename = attributes[@"filename"];
    file.patch = attributes[@"patch"];
    return file;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *commits = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [commits addObject:[self initWithDictionary:attributes]];
    }
    return commits;
}

@end