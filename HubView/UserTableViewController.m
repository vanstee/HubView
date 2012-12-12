#import "UserTableViewController.h"
#import "RepositoryTableViewController.h"

@implementation UserTableViewController

- (void)setUsers:(NSArray *)users
{
    if (_users != users)
    {
        _users = users;
        [self.tableView reloadData];
    }
}

- (void)updateBarButtonItem
{
    UINavigationController *detailController = [self.splitViewController.viewControllers objectAtIndex:1];
    CommitViewController *commitViewController = [detailController.viewControllers objectAtIndex:0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Users";
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateBarButtonItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select User"]) {
        User *user = [self.users objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [segue.destinationViewController setUser:user];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    Search *search = [Search initWithDictionary:@{@"keyword" : searchText}];
    [search usersWithCompletionBlock:^(NSArray *users) { self.users = users; }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"User";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }
    
    User *user = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = user.login;
    
    return cell;
}

@end