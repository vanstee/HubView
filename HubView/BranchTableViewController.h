#import <UIKit/UIKit.h>

@class Repository;

@interface BranchTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *branches;
@property (nonatomic, strong) Repository *repository;

@end
