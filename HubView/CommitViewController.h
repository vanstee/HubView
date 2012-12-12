#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@class Commit;

@interface CommitViewController : UIViewController

@property (nonatomic, strong) Commit *commit;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end
