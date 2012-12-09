#import <UIKit/UIKit.h>

@interface UserTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSString *search;

@end
