#import "File.h"

@implementation File

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *files = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [files addObject:[[File alloc] initWithDictionary:attributes]];
    }
    return files;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.filename = attributes[@"filename"];
        self.patch = [[Patch alloc] initWithRawPatch:attributes[@"patch"]];
    }
    return self;
}

@end
