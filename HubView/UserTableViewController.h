#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface UserTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *users;

@end
