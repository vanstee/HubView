#import <UIKit/UIKit.h>

#import "Commit.h"
#import "File.h"

@interface CommitViewController : UIViewController

@property (nonatomic, strong) Commit *commit;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end
