#import "File.h"

@implementation File

+ (File *)initWithDictionary:(NSDictionary *)attributes
{
    File *file = [File new];
    file.filename = attributes[@"filename"];
    file.patch = attributes[@"patch"];
    return file;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *files = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [files addObject:[self initWithDictionary:attributes]];
    }
    return files;
}

@end
