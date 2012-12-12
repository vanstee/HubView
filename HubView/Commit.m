#import "Commit.h"

@implementation Commit

+ (NSDate *)parseDate:(NSString *)dateString
{
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    return [dateFormatter dateFromString:dateString];
}

+ (Commit *)initWithDictionary:(NSDictionary *)attributes
{
    Commit *commit = [Commit new];
    commit.message = [[attributes[@"commit"][@"message"] componentsSeparatedByString: @"\n"] objectAtIndex:0];
    commit.date = [Commit parseDate:attributes[@"commit"][@"author"][@"date"]];
    commit.author = [User initWithDictionary:attributes[@"author"]];
    commit.files = [File initWithArrayOfDictionaries:attributes[@"files"]];
    return commit;
}

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries
{
    NSMutableArray *commits = [NSMutableArray arrayWithCapacity:[arrayOfDictionaries count]];
    for (NSDictionary *attributes in arrayOfDictionaries) {
        [commits addObject:[self initWithDictionary:attributes]];
    }
    return commits;
}

- (NSString *)detail
{
    return [NSString stringWithFormat:@"%@ authored %@", self.author.login, self.date.distanceOfTimeInWords];
}

@end