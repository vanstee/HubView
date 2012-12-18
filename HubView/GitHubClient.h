#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface GitHubClient : AFHTTPClient

+ (GitHubClient *)sharedClient;

@end
