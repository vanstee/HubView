#import "GitUser.h"

@implementation GitUser

- (id)initWithDictionary:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.email = attributes[@"email"];
        self.date = [NSDate parseDate:attributes[@"date"]];
    }
    return self;
}

@end
