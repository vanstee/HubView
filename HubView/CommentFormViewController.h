#import <UIKit/UIKit.h>

@class CommentFormViewController;
@class Line;

@protocol CommentFormViewControllerDelegate <NSObject>

@optional

- (void)commentFormViewController:(CommentFormViewController *)commentFormViewController wasSubmitted:(id)sender withLine:(Line *)line;
- (void)commentFormViewController:(CommentFormViewController *)commentFormViewController wasCancelled:(id)sender;

@end

@interface CommentFormViewController : UIViewController

@property (nonatomic, assign) id<CommentFormViewControllerDelegate>delegate;
@property (nonatomic, weak) IBOutlet UITextView *commentBody;
@property (nonatomic, weak) Line *line;

- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;

@end
