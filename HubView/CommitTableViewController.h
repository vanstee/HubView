#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface CommitTableViewController : UITableViewController

@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) NSArray *commits;

@end
