#import "PrettyButton.h"

#import <QuartzCore/QuartzCore.h>

@implementation PrettyButton {
    CAGradientLayer *background;
    CAGradientLayer *highlight;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor commitMessageFontColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];

        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor commentButtonBorderColor].CGColor;

        background = [CAGradientLayer new];
        background.frame = self.bounds;
        background.colors = @[(id)[UIColor commentButtonBackgroundGradientStartColor].CGColor, (id)[UIColor commentButtonBackgroundGradientEndColor].CGColor];
        [self.layer insertSublayer:background atIndex:0];

        highlight = [CAGradientLayer new];
        highlight.frame = self.bounds;
        highlight.hidden = YES;
        highlight.colors = @[(id)[UIColor colorWithRed:219.0/255.0 green:222.0/255.0 blue:231.0/255.0 alpha:1].CGColor, (id)[UIColor commentButtonBackgroundGradientEndColor].CGColor];
        [self.layer insertSublayer:highlight atIndex:1];
    }

    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    highlight.hidden = !highlighted;
    [CATransaction commit];
    [super setHighlighted:highlighted];
}

@end