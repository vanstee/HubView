#import <Foundation/Foundation.h>

static NSString* const kCredentialsChangedNotification = @"CredentialsChangedNotification";

@interface GitHubCredentials : NSObject

+ (GitHubCredentials *)sharedCredentials;

- (BOOL)setUsername:(NSString *)username password:(NSString *)password;
- (NSString *)username;
- (NSString *)password;
    
@end
