#import "Comment.h"

#import <GHMarkdownParser.h>
#import "User.h"

@implementation Comment

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:arrayOfDictionaries.count];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [comments addObject:[[Comment alloc] initWithDictionary:attributes]];
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
        if (attributes[@"line"] != [NSNull null]) { self.line = [attributes[@"line"] integerValue]; }
        if (attributes[@"position"] != [NSNull null]) { self.position = [attributes[@"position"] integerValue]; }
        if (attributes[@"path"] != [NSNull null]) { self.path = attributes[@"path"]; }
    }
    return self;
}

- (NSString *)parsedBody
{
    return self.body.HTMLStringFromMarkdown;
}

@end
