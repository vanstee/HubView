#import "LineLabel.h"

#import "CommentFormViewController.h"
#import "CommitViewController.h"
#import "Line.h"

@implementation LineLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.font = [UIFont fontWithName:@"Menlo" size:12];
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (void)setLine:(Line *)line
{
    _line = line;

    self.text = [NSString stringWithFormat:@" %@", line.rawLine];
    self.textColor = line.textColor;
    self.backgroundColor = line.backgroundColor;
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [touches.anyObject locationInView:self];

    if (CGRectContainsPoint(self.bounds, location)) {
        CommitViewController *commitViewController = [self commitViewController];
        [commitViewController displayCommentFormForLineLabel:self];
    }
}

- (CommitViewController *)commitViewController
{
    id responder = [self nextResponder];

    while (responder) {
        if ([responder isKindOfClass:[UIView class]]) {
            responder = [responder nextResponder];
        } else if ([responder isKindOfClass:[UIViewController class]]) {
            return responder;
        }
    }

    return responder;
}

@end