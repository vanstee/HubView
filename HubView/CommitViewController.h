#import <UIKit/UIKit.h>
#import "Commit.h"
#import "File.h"

@interface CommitViewController : UIViewController

@property (nonatomic, strong) Commit *commit;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, weak) IBOutlet UITextView *diff;

@end
