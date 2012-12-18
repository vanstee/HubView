#import <Foundation/Foundation.h>

#import "Commit.h"
#import "File.h"
#import "Repository.h"
#import "User.h"

@class Repository;
@class User;

@interface Commit : NSObject

@property (nonatomic, strong) NSString *sha;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) Repository *repository;
@property (nonatomic, strong) NSArray *files;

+ (NSDate *)parseDate:(NSString *)date;

+ (Commit *)initWithDictionary:(NSDictionary *)attributes;

+ (NSArray *)initWithArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

- (NSString *)detail;

- (void)commitWithCompletionBlock:(void (^)(Commit *commit))block;

@end
