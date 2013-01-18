#import "AFHTTPClient.h"

@interface GitHubClient : AFHTTPClient

+ (GitHubClient *)sharedClient;

@end
