#import <UIKit/UIKit.h>
#import "Commit.h"
#import "CommitView.h"
#import "LoginViewController.h"

@interface CommitViewController : UIViewController <LoginViewControllerDelegate>

@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet CommitView *commitView;

- (void)setCommit:(Commit *)commit;

@end
