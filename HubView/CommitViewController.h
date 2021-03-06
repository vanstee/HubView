#import <UIKit/UIKit.h>
#import "CommentFormViewController.h"
#import "LoginViewController.h"

@class Commit;
@class CommitView;
@class LineLabel;

@interface CommitViewController : UIViewController <LoginViewControllerDelegate, CommentFormViewControllerDelegate>

@property (nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet CommitView *commitView;

- (void)setCommit:(Commit *)commit;
- (void)displayCommentFormForLineLabel:(LineLabel *)lineLabel;
- (void)displayCommentFormForButton:(UIButton *)button line:(Line *)line;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end