#import "CommitTableViewController.h"

@class CommitViewController;

@implementation CommitTableViewController

- (void)setCommits:(NSArray *)commits
{
    if (_commits != commits)
    {
        _commits = commits;
        [self.tableView reloadData];
    }
}

- (void)setBranch:(Branch *)branch
{
    if (_branch != branch)
    {
        _branch = branch;
        [branch commitsWithCompletionBlock:^(NSArray *commits) { self.commits = commits; }];
    }
}

- (void)updateBarButtonItem
{
    UINavigationController *detailController = [self.splitViewController.viewControllers objectAtIndex:1];
    CommitViewController *commitViewController = [detailController.viewControllers objectAtIndex:0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Commits";
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateBarButtonItem];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Commit"]) {
        Commit *commit = [self.commits objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        //[segue.destinationViewController setCommit:commit];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Commit";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Commit *commit = [self.commits objectAtIndex:indexPath.row];
    cell.textLabel.text = commit.message;
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    cell.detailTextLabel.text = commit.detail;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Commit";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Commit *commit = [self.commits objectAtIndex:indexPath.row];
    
    NSInteger padding = 20;
    
    CGSize lineSize =       [@" "           sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    CGSize textSize =       [commit.message sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    CGSize detailTextSize = [commit.detail  sizeWithFont:[UIFont systemFontOfSize:14]     constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    
    return MIN(lineSize.height * 3, textSize.height) + detailTextSize.height + padding;
}

@end