#import <UIKit/UIKit.h>
#import "Branch.h"
#import "CommitTableViewController.h"
#import "Repository.h"

@interface BranchTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *branches;
@property (nonatomic, strong) Repository *repository;

@end
