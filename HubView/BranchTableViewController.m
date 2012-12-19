#import "BranchTableViewController.h"

@implementation BranchTableViewController

- (void)setBranches:(NSArray *)branches
{
    if (_branches != branches)
    {
        _branches = branches;
        [self.tableView reloadData];
    }
}

- (void)setRepository:(Repository *)repository
{
    if (_repository != repository)
    {
        _repository = repository;
        [repository branchesWithCompletionBlock:^(NSArray *branches) { self.branches = branches; }];
    }
}

- (void)updateBarButtonItem
{
    UINavigationController *detailController = self.splitViewController.viewControllers[1];
    CommitViewController *commitViewController = detailController.viewControllers[0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Branches";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBarButtonItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Branch"]) {
        Branch *branch = self.branches[self.tableView.indexPathForSelectedRow.row];
        [segue.destinationViewController setBranch:branch];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.branches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Branch";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }
    
    Branch *branch = self.branches[indexPath.row];
    cell.textLabel.text = branch.name;
    
    return cell;
}

@end