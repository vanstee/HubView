//
//  LoginViewController.h
//  HubView
//
//  Created by ADML on 2012-12-30.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewController:(LoginViewController *)loginViewController wasSaved:(id)sender;
- (void)loginViewController:(LoginViewController *)loginViewController wasCancelled:(id)sender;

@end

@interface LoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<LoginViewControllerDelegate>delegate;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (IBAction)saveButtonTapped:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;

@end
