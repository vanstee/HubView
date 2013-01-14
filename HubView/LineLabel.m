#import "LineLabel.h"

@implementation LineLabel

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.font = [UIFont fontWithName:@"Menlo" size:12];
    }

    return self;
}

- (void)setLine:(Line *)line
{
    self.text = [NSString stringWithFormat:@" %@", line.rawLine];
    self.textColor = line.textColor;
    self.backgroundColor = line.backgroundColor;
}

@end