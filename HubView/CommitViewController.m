#import "CommitViewController.h"

#import "CommitView.h"

@interface CommitViewController () {
    UIBarButtonItem *loginButton;
    LoginViewController *loginViewController;
    UIPopoverController *loginPopoverController;
}
@end

@implementation CommitViewController

- (void)loginButtonTapped:(id)sender {
    [self makeLoginViewController];
    [self makeLoginPopoverController];
    
    [loginPopoverController presentPopoverFromBarButtonItem:loginButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)makeLoginViewController {
    if (!loginViewController) {
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        loginViewController.delegate = self;
    }
}

- (void)makeLoginPopoverController {
    if (!loginPopoverController) {
        loginPopoverController = [[UIPopoverController alloc] initWithContentViewController:loginViewController];
    }
}

- (void)setCommit:(Commit *)commit
{
    self.commitView.partialCommit = commit;
    if (self.masterPopoverController) { [self.masterPopoverController dismissPopoverAnimated:YES]; }
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Users";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    
    [self makeLoginButton];
    [self.navigationItem setRightBarButtonItem:loginButton animated:YES];
    
    self.masterPopoverController = popoverController;
}

- (void)makeLoginButton {
    if (!loginButton) {
        loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(loginButtonTapped:)];
    }
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.autoresizesSubviews = YES;
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [(CommitView *)self.view refresh];
}

#pragma mark - Login View Controller Delegate
- (void)loginViewController:(LoginViewController *)loginViewController wasSaved:(id)sender {
    [loginPopoverController dismissPopoverAnimated:YES];
}

- (void)loginViewController:(LoginViewController *)loginViewController wasCancelled:(id)sender {
    [loginPopoverController dismissPopoverAnimated:YES];
}

@end