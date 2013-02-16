#import <Foundation/Foundation.h>

@class Repository;

@interface Branch : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Repository *repository;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;
- (id)initWithDictionary:(NSDictionary *)attributes;
- (void)commitsAfterSHA:(NSString *)sha withCompletionBlock:(void (^)(NSArray *commits))block;
- (void)commitsWithCompletionBlock:(void (^)(NSArray *commits))block;

@end