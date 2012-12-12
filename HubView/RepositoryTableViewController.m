#import "RepositoryTableViewController.h"

@implementation RepositoryTableViewController

- (void)setUser:(User *)user
{
    if (_user != user)
    {
        _user = user;
        [user repositoriesWithCompletionBlock:^(NSArray *repositories) { self.repositories = repositories; }];
    }
}

- (void)setRepositories:(NSArray *)repositories
{
    if (_repositories != repositories)
    {
        _repositories = repositories;
        [self.tableView reloadData];
    }
}

- (void)updateBarButtonItem
{
    UINavigationController *detailController = [self.splitViewController.viewControllers objectAtIndex:1];
    CommitViewController *commitViewController = [detailController.viewControllers objectAtIndex:0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Repositories";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBarButtonItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Repository"]) {
        Repository *repository = [self.repositories objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [segue.destinationViewController setRepository:repository];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.repositories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Repository";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Repository *repository = [self.repositories objectAtIndex:indexPath.row];
    cell.textLabel.text = repository.name;
    
    return cell;
}

@end