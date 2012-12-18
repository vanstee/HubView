#import <UIKit/UIKit.h>
#import "CommitViewController.h"
#import "Repository.h"
#import "User.h"

@interface RepositoryTableViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *repositories;

@end
