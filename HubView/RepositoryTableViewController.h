#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface RepositoryTableViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *repositories;

@end
