#import "UserTableViewController.h"

#import "CommitViewController.h"
#import "Search.h"
#import "RepositoryTableViewController.h"
#import "User.h"

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
    UINavigationController *detailController = self.splitViewController.viewControllers[1];
    CommitViewController *commitViewController = detailController.viewControllers[0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Users";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBarButtonItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select User"]) {
        User *user = self.users[self.tableView.indexPathForSelectedRow.row];
        [segue.destinationViewController setUser:user];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    Search *search = [[Search alloc] initWithDictionary:@{@"keyword" : searchText}];
    [search usersWithCompletionBlock:^(NSArray *users) { self.users = users; }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"User";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }
    
    User *user = self.users[indexPath.row];
    cell.textLabel.text = user.login;
    
    return cell;
}

@end