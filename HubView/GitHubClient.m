#import "GitHubClient.h"

#import "AFJSONRequestOperation.h"

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
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Content-Type" value:@"application/json"];
        self.loggedIn = NO;
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [self setAuthorizationHeaderWithUsername:username password:password];
    self.loggedIn = YES;
}

- (void)logout {
    [[GitHubClient sharedClient] clearAuthorizationHeader];
    self.loggedIn = NO;
}

@end
