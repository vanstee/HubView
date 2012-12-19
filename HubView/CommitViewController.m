#import "CommitViewController.h"

@implementation CommitViewController

- (void)setCommit:(Commit *)commit
{
    self.commitView.commit = commit;
    if (self.masterPopoverController) { [self.masterPopoverController dismissPopoverAnimated:YES]; }
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.autoresizesSubviews = YES;
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
}

@end