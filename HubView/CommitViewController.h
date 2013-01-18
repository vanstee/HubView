#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@class Commit;
@class CommitView;

@interface CommitViewController : UIViewController <LoginViewControllerDelegate>

@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet CommitView *commitView;

- (void)setCommit:(Commit *)commit;

@end
