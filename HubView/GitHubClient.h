#import "AFHTTPClient.h"

@interface GitHubClient : AFHTTPClient

@property (readwrite, assign) BOOL loggedIn;

+ (GitHubClient *)sharedClient;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)logout;

@end
