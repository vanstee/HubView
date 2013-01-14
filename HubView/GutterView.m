#import "GutterView.h"

@implementation GutterView

- (id)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;

        CGRect beforeLineNumberViewFrame = CGRectMake(-1, -1, LINE_NUMBER_VIEW_WIDTH, self.frame.size.height + 2);
        self.beforeLineNumberView = [[BeforeLineNumberView alloc] initWithFrame:beforeLineNumberViewFrame];

        CGRect afterLineNumberViewFrame = CGRectMake(LINE_NUMBER_VIEW_WIDTH - 2, -1, LINE_NUMBER_VIEW_WIDTH, self.frame.size.height + 2);
        self.afterLineNumberView = [[AfterLineNumberView alloc] initWithFrame:afterLineNumberViewFrame];
    }
    return self;
}

- (void)setFile:(File *)file
{
    [self.beforeLineNumberView setFile:file];
    [self.afterLineNumberView setFile:file];
    [self addSubview:self.beforeLineNumberView];
    [self addSubview:self.afterLineNumberView];

    self.frame = self.beforeLineNumberView.frame;
}

- (void)setFileContentViewWidth:(CGFloat)fileContentViewWidth
{
    self.beforeLineNumberView.fileContentViewWidth = fileContentViewWidth;
    self.afterLineNumberView.fileContentViewWidth = fileContentViewWidth;
}

@end
