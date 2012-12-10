#import <UIKit/UIKit.h>

#import "BranchTableViewController.h"
#import "User.h"
#import "Repository.h"

@interface RepositoryTableViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *repositories;

@end
