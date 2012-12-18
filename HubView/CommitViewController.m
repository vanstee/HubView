#import "CommitViewController.h"

@implementation CommitViewController

- (void)setCommit:(Commit *)commit
{
    if (_commit != commit)
    {
        [commit commitWithCompletionBlock:^(Commit *commit) {
            _commit = commit;
            [self displayCommit];
        }];
        if (self.masterPopoverController) { [self.masterPopoverController dismissPopoverAnimated:YES]; }
    }
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Users";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayCommit];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)displayCommit
{
    self.view.autoresizesSubviews = YES;
    self.view.backgroundColor = [UIColor underPageBackgroundColor];

    if (self.commit.files) {
        self.diff.text = [[self.commit.files valueForKey:@"patch"] componentsJoinedByString:@"\n"];
    }
}

@end