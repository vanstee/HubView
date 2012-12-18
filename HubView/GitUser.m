#import "GitUser.h"

@implementation GitUser

+ (GitUser *)initWithDictionary:(NSDictionary *)attributes
{
    GitUser *gitUser = [GitUser new];
    gitUser.name = attributes[@"name"];
    gitUser.email = attributes[@"email"];
    gitUser.date = [NSDate parseDate:attributes[@"date"]];
    return gitUser;
}

@end
