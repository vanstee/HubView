//
//  GitHubCredentials.h
//  HubView
//
//  Created by ADML on 2012-12-30.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const kCredentialsChangedNotification = @"CredentialsChangedNotification";

@interface GitHubCredentials : NSObject

+ (GitHubCredentials *)sharedCredentials;

- (BOOL)setUsername:(NSString *)username password:(NSString *)password;
- (NSString *)username;
- (NSString *)password;
    
@end
