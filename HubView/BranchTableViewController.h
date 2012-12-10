#import <UIKit/UIKit.h>

#import "Branch.h"
#import "Repository.h"
#import "User.h"

@interface BranchTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *branches;
@property (nonatomic, strong) Repository *repository;
@property (nonatomic, strong) User *user;

@end
