#import "AFHTTPClient.h"

@interface AFGitHubClient : AFHTTPClient

+ (AFGitHubClient *)sharedClient;

+ (void)setSharedClient:(AFGitHubClient *)client;

@end
