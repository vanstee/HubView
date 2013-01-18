#import <UIKit/UIKit.h>

@class User;

@interface RepositoryTableViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *repositories;

@end
