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

- (void)updateBarButtonItem
{
    UINavigationController *detailController = self.splitViewController.viewControllers[1];
    CommitViewController *commitViewController = detailController.viewControllers[0];
    commitViewController.navigationItem.leftBarButtonItem.title = @"Commits";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBarButtonItem];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commit *commit = self.commits[self.tableView.indexPathForSelectedRow.row];
    UINavigationController *detailController = self.splitViewController.viewControllers[1];
    CommitViewController *commitViewController = detailController.viewControllers[0];
    commitViewController.commit = commit;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Commit";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }
    
    Commit *commit = self.commits[indexPath.row];

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

    if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }

    Commit *commit = self.commits[indexPath.row];
    
    CGSize lineSize =       [@" "           sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    CGSize textSize =       [commit.message sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    CGSize detailTextSize = [commit.detail  sizeWithFont:[UIFont systemFontOfSize:14]     constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];
    
    return MIN(lineSize.height * 3, textSize.height) + detailTextSize.height + PADDING;
}

@end