#import "Comment.h"

@implementation Comment

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        if (attributes[@"path"] != [NSNull null]) {
            [comments addObject:[[Comment alloc] initWithDictionary:attributes]];
        }
    }
    return comments;
}

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.body = attributes[@"body"];
        self.user = [[User alloc] initWithDictionary:attributes[@"user"]];
        self.createdAt = [NSDate parseDate:attributes[@"created_at"]];
        self.line = [attributes[@"line"] integerValue];
        self.position = [attributes[@"position"] integerValue];
        self.path = attributes[@"path"];
    }
    return self;
}

@end
