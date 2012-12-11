#import <UIKit/UIKit.h>

#import "User.h"

@interface UserTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *users;

@end
