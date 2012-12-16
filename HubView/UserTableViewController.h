#import <UIKit/UIKit.h>

#import "CommitViewController.h"
#import "Search.h"

@interface UserTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *users;

@end
