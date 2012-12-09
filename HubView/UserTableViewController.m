#import "UserTableViewController.h"
#import "User.h"

@implementation UserTableViewController

@synthesize users = _users;
@synthesize search = _search;

- (void)setUsers:(NSArray *)users
{
    if (_users != users)
    {
        _users = users;
        [self.tableView reloadData];
    }
}

- (void)setSearch:(NSString *)search
{
    if (_search != search) {
        _search = search;
        // do the search
    }
}

#pragma mark - View lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select User"]) {
        User *user = [self.users objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSArray *organizations = ((AppDelegate *)[UIApplication sharedApplication].delegate).organizations;
        Organization *organization = [Organization findUser:user inOrganizations:organizations];
        
        if (organization != NULL)
        {
            [segue.destinationViewController setOrganization:organization];
        }
        else
        {
            [segue.destinationViewController setUser:user];
        }
    }
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.search = searchText;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"User";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    User *user = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = user.login;
    
    return cell;
}

@end