#import "RepositoryTableViewController.h"

@implementation RepositoryTableViewController

@synthesize user = _user;
@synthesize repositories = _repositories;

- (void)setUser:(User *)user
{
    if (_user != user)
    {
        _user = user;
        [Repository findRepositoriesForUser:user withCompletionBlock:^(NSArray *repositories){ self.repositories = repositories; }];
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

#pragma mark - View lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue.identifier: %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"Select Repository"]) {
        Repository *repository = [self.repositories objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSLog(@"repository: %@", repository);
        [segue.destinationViewController setRepository:repository];
        [segue.destinationViewController setUser:self.user];
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