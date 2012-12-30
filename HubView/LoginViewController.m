//
//  LoginViewController.m
//  HubView
//
//  Created by ADML on 2012-12-30.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import "LoginViewController.h"
#import "HVTextFieldCell.h"

enum LoginViewCells {
    kUsernameCellIndex = 0,
    kPasswordCellIndex,
    kNumberOfCells
};

@interface LoginViewController () {
    HVTextFieldCell *usernameCell;
    HVTextFieldCell *passwordCell;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = self.view.bounds.size;
        
        usernameCell = [[HVTextFieldCell alloc] initWithReuseIdentifier:@"UsernameCell"];
        usernameCell.textLabel.text = @"Username";
        usernameCell.textField.placeholder = @"vanstee";
        
        passwordCell = [[HVTextFieldCell alloc] initWithReuseIdentifier:@"PasswordCell"];
        passwordCell.textLabel.text = @"Password";
        passwordCell.textField.secureTextEntry = YES;
        passwordCell.textField.placeholder = @"Required";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfCells;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kUsernameCellIndex:
            return usernameCell;
        case kPasswordCellIndex:
            return passwordCell;
    }
    
    return nil;
}

- (IBAction)saveButtonTapped:(id)sender {
    if ([self validateInputs]) {
        if ([self.delegate respondsToSelector:@selector(loginViewController:wasSaved:)]) {
            [self.delegate loginViewController:self wasSaved:sender];
        }
    }
}

- (IBAction)cancelButtonTouched:(id)sender {
    if ([self.delegate respondsToSelector:@selector(loginViewController:wasCancelled:)]) {
        [self.delegate loginViewController:self wasCancelled:sender];
    }
}

- (BOOL)validateInputs {
    if (usernameCell.textField.text.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Username" message:@"Please enter your GitHub username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    
    if (passwordCell.textField.text.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Password" message:@"Please enter your GitHub password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
        
    }
    
    return YES;
}

@end
