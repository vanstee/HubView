#import <UIKit/UIKit.h>
#import "Commit.h"
#import "CommitView.h"

@interface CommitViewController : UIViewController

@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet CommitView *commitView;

- (void)setCommit:(Commit *)commit;

@end
