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

#pragma mark - View lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Branch"]) {
        Branch *branch = [self.branches objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [segue.destinationViewController setBranch:branch];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.branches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Branch";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Branch *branch = [self.branches objectAtIndex:indexPath.row];
    cell.textLabel.text = branch.name;
    
    return cell;
}

@end