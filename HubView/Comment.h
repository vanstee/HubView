#import <Foundation/Foundation.h>

@class User;

@interface Comment : NSObject

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger position;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
- (id)initWithDictionary:(NSDictionary *)attributes;
- (NSString *)parsedBody;

@end