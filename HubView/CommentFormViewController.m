#import "CommentFormViewController.h"

@implementation CommentFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = self.view.bounds.size;
    }

    return self;
}

- (IBAction)submitButtonTapped:(id)sender {
    if ([self validateInputs]) {
        if ([self.delegate respondsToSelector:@selector(commentFormViewController:wasSubmitted:withLine:)]) {
            [self.delegate commentFormViewController:self wasSubmitted:sender withLine:self.line];
        }
    }
}

- (IBAction)cancelButtonTouched:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentFormViewController:wasCancelled:)]) {
        [self.delegate commentFormViewController:self wasCancelled:sender];
    }
}

- (BOOL)validateInputs {
    if (self.commentBody.text.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Comment" message:@"Please fill in the comment field" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }

    return YES;
}

@end
