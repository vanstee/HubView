#import <UIKit/UIKit.h>

#define PADDING 20

@class Branch;

@interface CommitTableViewController : UITableViewController

@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) NSArray *commits;

@end
