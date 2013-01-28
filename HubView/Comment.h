#import <Foundation/Foundation.h>

@class Commit;
@class User;

@interface Comment : NSObject

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, weak) Commit *commit;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
+ (void)submitComment:(Comment *)comment completionBlock:(void (^)(bool))block;
- (id)initWithDictionary:(NSDictionary *)attributes;
- (NSString *)parsedBody;

@end