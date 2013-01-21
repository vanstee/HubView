#import "GutterView.h"

#import "BeforeLineNumberView.h"
#import "AfterLineNumberView.h"

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
    self.beforeLineNumberView.file = file;
    self.afterLineNumberView.file = file;

    [self addSubview:self.beforeLineNumberView];
    [self addSubview:self.afterLineNumberView];

    self.frame = self.beforeLineNumberView.frame;
}

- (void)setFileContentView:(FileContentView *)fileContentView
{
    _fileContentView = fileContentView;
    self.beforeLineNumberView.fileContentView = fileContentView;
    self.afterLineNumberView.fileContentView = fileContentView;
}

@end
