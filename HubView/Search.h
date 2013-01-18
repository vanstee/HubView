#import <Foundation/Foundation.h>

@interface Search : NSObject

@property (nonatomic, strong) NSString *keyword;

- (id)initWithDictionary:(NSDictionary *)attributes;
- (void)usersWithCompletionBlock:(void (^)(NSArray *users))block;

@end
