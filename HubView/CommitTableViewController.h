#import <UIKit/UIKit.h>

#import "Branch.h"
#import "Commit.h"
#import "Repository.h"
#import "User.h"

@interface CommitTableViewController : UITableViewController

@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) NSArray *commits;

@end
