#import "CommitTableViewController.h"

#import "Branch.h"
#import "Commit.h"
#import "CommitViewController.h"

@implementation CommitTableViewController {
    BOOL moreToLoad;
}

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
        moreToLoad = YES;
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
    [commitViewController setCommit:commit];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreToLoad ? self.commits.count + 1 : self.commits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.commits.count) {
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
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Loading"];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.center = cell.center;
        [cell addSubview:activityIndicator];

        [activityIndicator startAnimating];

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.commits.count) {
        static NSString *CellIdentifier = @"Commit";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!cell) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }

        Commit *commit = self.commits[indexPath.row];

        CGSize lineSize =       [@" "           sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];
        CGSize textSize =       [commit.message sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];
        CGSize detailTextSize = [commit.detail  sizeWithFont:[UIFont systemFontOfSize:14]     constrainedToSize:CGSizeMake(cell.contentView.frame.size.width - PADDING, 500) lineBreakMode:NSLineBreakByTruncatingTail];

        return MIN(lineSize.height * 3, textSize.height) + detailTextSize.height + PADDING;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell.reuseIdentifier isEqualToString:@"Loading"] && self.commits.lastObject) {
        [self.branch commitsAfterSHA:[self.commits.lastObject sha] withCompletionBlock:^(NSArray *commits) {
            if (commits.count == 0) {
                moreToLoad = NO;
                [self.tableView reloadData];
            } else {
                self.commits = [self.commits arrayByAddingObjectsFromArray:commits];
            }
        }];
    }
}

@end