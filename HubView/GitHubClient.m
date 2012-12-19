#import "GitHubClient.h"

@implementation GitHubClient

+ (id)sharedClient {
    static GitHubClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GitHubClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    });

    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

@end
