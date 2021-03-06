#import "GitHubCredentials.h"

#import "GitHubClient.h"
#import <SSKeychain.h>

#define HUBVIEW_KEYCHAIN_SERVICE @"HubView"

@implementation GitHubCredentials

+ (GitHubCredentials *)sharedCredentials {
    static GitHubCredentials *shared = nil;
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shared = [[GitHubCredentials alloc] init];
    });
    
    return shared;
}

- (BOOL)setUsername:(NSString *)username password:(NSString *)password {
    [self clearExistingAccounts];
    
    BOOL success = [SSKeychain setPassword:password forService:HUBVIEW_KEYCHAIN_SERVICE account:username];
    if (success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kCredentialsChangedNotification object:self];
        [[GitHubClient sharedClient] loginWithUsername:username password:password];
    }
    
    return success;
}

- (void)clearExistingAccounts {
    NSArray *accounts = [SSKeychain accountsForService:HUBVIEW_KEYCHAIN_SERVICE];
    for (NSDictionary *account in accounts) {
        [SSKeychain deletePasswordForService:HUBVIEW_KEYCHAIN_SERVICE account:[account objectForKey:kSSKeychainAccountKey]];
    }
}

- (NSString *)username {
    NSArray *accounts = [SSKeychain accountsForService:HUBVIEW_KEYCHAIN_SERVICE];
    if (accounts.count >= 1) {
        return [[accounts objectAtIndex:0] objectForKey:kSSKeychainAccountKey];
    } else {
        return nil;
    }
}

- (NSString *)password {
    NSString *username = [self username];
    if (username) {
        return [SSKeychain passwordForService:HUBVIEW_KEYCHAIN_SERVICE account:username];
    } else {
        return nil;
    }
}

@end
