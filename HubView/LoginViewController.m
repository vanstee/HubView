#import "LoginViewController.h"

#import "HVTextFieldCell.h"
#import "GitHubCredentials.h"

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
        usernameCell.textField.placeholder = @"Required";
        
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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    GitHubCredentials *credentials = [GitHubCredentials sharedCredentials];
    if (credentials.username) {
        usernameCell.textField.text = credentials.username;
    }
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
        GitHubCredentials *credentials = [GitHubCredentials sharedCredentials];
        if ([credentials setUsername:self.username password:self.password]) {
            if ([self.delegate respondsToSelector:@selector(loginViewController:wasSaved:)]) {
                [self.delegate loginViewController:self wasSaved:sender];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"We could not save your credentials at this time. Please try again soon." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

- (IBAction)cancelButtonTouched:(id)sender {
    if ([self.delegate respondsToSelector:@selector(loginViewController:wasCancelled:)]) {
        [self.delegate loginViewController:self wasCancelled:sender];
    }
}

- (BOOL)validateInputs {
    if (self.username.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Username" message:@"Please enter your GitHub username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    
    if (self.password.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Password" message:@"Please enter your GitHub password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
        
    }
    
    return YES;
}

- (NSString *)username {
    return usernameCell.textField.text;
}

- (NSString *)password {
    return passwordCell.textField.text;
}

- (void)clearInputs {
    usernameCell.textField.text = @"";
    passwordCell.textField.text = @"";
}

@end
