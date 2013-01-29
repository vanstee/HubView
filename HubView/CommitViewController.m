#import "CommitViewController.h"

#import "Comment.h"
#import "CommitView.h"
#import "CommentFormViewController.h"
#import "File.h"
#import "GitHubCredentials.h"
#import "Line.h"
#import "LineLabel.h"
#import "Patch.h"
#import "User.h"

@interface CommitViewController () {
    UIBarButtonItem *loginButton;
    LoginViewController *loginViewController;
    UIPopoverController *loginPopoverController;
    CommentFormViewController *commentFormViewController;
    UIPopoverController *commentFormPopoverController;
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

- (void)displayCommentFormForLineLabel:(LineLabel *)lineLabel
{
    commentFormViewController = [[CommentFormViewController alloc] initWithNibName:@"CommentFormViewController" bundle:nil];
    commentFormViewController.delegate = self;
    commentFormViewController.line = lineLabel.line;
    commentFormPopoverController = [[UIPopoverController alloc] initWithContentViewController:commentFormViewController];
    [commentFormPopoverController presentPopoverFromRect:lineLabel.bounds inView:lineLabel permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
}

- (void)displayCommentFormForButton:(UIButton *)button line:(Line *)line
{
    commentFormViewController = [[CommentFormViewController alloc] initWithNibName:@"CommentFormViewController" bundle:nil];
    commentFormViewController.delegate = self;
    commentFormViewController.line = line;
    commentFormPopoverController = [[UIPopoverController alloc] initWithContentViewController:commentFormViewController];
    [commentFormPopoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - Login View Controller Delegate

- (void)loginViewController:(LoginViewController *)loginViewController wasSaved:(id)sender {
    [loginPopoverController dismissPopoverAnimated:YES];
}

- (void)loginViewController:(LoginViewController *)loginViewController wasCancelled:(id)sender {
    [loginPopoverController dismissPopoverAnimated:YES];
}

#pragma mark - CommentFormViewControllerDelegate


- (void)commentFormViewController:(CommentFormViewController *)controller wasSubmitted:(id)sender withLine:(Line *)line
{
    File *file = line.patch.file;
    Commit *commit = file.commit;
    Comment *comment = [[Comment alloc] initWithDictionary:@{
                            @"commit": commit,
                            @"path": file.filename,
                            @"line": @(line.beforeLineNumber),
                            @"position": @([file.patch.lines indexOfObject:line]),
                            @"body": controller.commentBody.text
                        }];
    comment.createdAt = [NSDate date];
    comment.user = [[User alloc] initWithDictionary:@{@"login": [GitHubCredentials sharedCredentials].username}];

    [Comment submitComment:comment completionBlock:^(bool successful) {
        if (successful) {
            [commentFormPopoverController dismissPopoverAnimated:YES];
            NSMutableArray *comments = [NSMutableArray arrayWithArray:self.commitView.comments];
            [comments addObject:comment];
            self.commitView.comments = comments;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There were problems submitting your comment. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (void)commentFormViewController:(CommentFormViewController *)commentFormViewController wasCancelled:(id)sender
{
    [commentFormPopoverController dismissPopoverAnimated:YES];
}

@end