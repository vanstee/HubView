#import <Foundation/Foundation.h>

@interface GitUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *date;

+ (GitUser *)initWithDictionary:(NSDictionary *)attributes;

@end
