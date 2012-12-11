#import "CommitTableViewController.h"

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

#pragma mark - View lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Commit"]) {
        Commit *commit = [self.commits objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        //[segue.destinationViewController setCommit:commit];
    }
}

#pragma mark - Table view data source

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
    NSString *text = commit.message;
    NSString *detailText = commit.detail;
    
    NSInteger padding = 20;
    
    CGSize lineSize = [@" "  sizeWithFont:[UIFont boldSystemFontOfSize:18]
                        constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500)
                            lineBreakMode:NSLineBreakByTruncatingTail];
    
    CGSize textSize = [commit.message sizeWithFont:[UIFont boldSystemFontOfSize:18]
                                 constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500)
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    
    CGSize detailTextSize = [commit.detail sizeWithFont:[UIFont systemFontOfSize:14]
                                      constrainedToSize:CGSizeMake([cell.contentView frame].size.width - padding, 500)
                                          lineBreakMode:NSLineBreakByTruncatingTail];
    
    if (lineSize.height * 3 < textSize.height)
    {
        return (lineSize.height * 3) + detailTextSize.height + padding;
    }
    else
    {
        return textSize.height + detailTextSize.height + padding;
    }
}

@end