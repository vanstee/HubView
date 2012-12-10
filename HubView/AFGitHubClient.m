#import "AFGitHubClient.h"

@implementation AFGitHubClient

static AFGitHubClient *sharedClient = nil;

+ (AFGitHubClient *)sharedClient
{
    return sharedClient;
}

+ (void)setSharedClient:(AFGitHubClient *)client
{
    sharedClient = client;
}

@end
