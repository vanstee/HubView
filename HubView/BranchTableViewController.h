#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@class Repository;

@interface BranchTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *branches;
@property (nonatomic, strong) Repository *repository;

@end
