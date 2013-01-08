#import "FileView.h"

@implementation FileView

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY file:(File *)file;
{
    if(self = [super initWithContainerFrame:containerFrame originY:originY height:0 title:file.filename]) {
        CGRect frame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, self.frame.size.width, self.frame.size.height);
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];

        NSInteger maxLineWidth = MAX(self.frame.size.width, file.patch.maxLineWidth);

        NSInteger linePosition = 0;

        LineNumberView *beforeLineNumberView = [LineNumberView new];
        LineNumberView *afterLineNumberView = [LineNumberView new];

        for (Line *line in file.patch.lines) {
            LineNumberLabel *beforeLineNumber = [[LineNumberLabel alloc] initWithText:line.beforeLineNumberString originY:linePosition];
            [beforeLineNumberView addSubview:beforeLineNumber];

            LineNumberLabel *afterLineNumber = [[LineNumberLabel alloc] initWithText:line.afterLineNumberString originY:linePosition];
            [afterLineNumberView addSubview:afterLineNumber];

            LineLabel *label = [[LineLabel alloc] initWithLine:line originY:linePosition width:maxLineWidth];
            [self.scrollView addSubview:label];

            linePosition += label.frame.size.height;

            if (line.comments) {
                UIView *commentsView = [CommitView createCommentsViewWithComments:line.comments color:label.backgroundColor andFileView:self];
                CGRect commentsViewFrame = commentsView.frame;
                commentsViewFrame.origin.x = LINE_NUMBER_VIEW_WIDTH;
                commentsViewFrame.origin.y = linePosition;
                commentsView.frame = commentsViewFrame;
                [self.scrollView addSubview:commentsView];
                linePosition += commentsView.frame.size.height;
            }
        }

        CGRect beforeFrame = CGRectMake(-1, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        beforeLineNumberView.frame = beforeFrame;
        [self.scrollView addSubview:beforeLineNumberView];

        CGRect afterFrame = CGRectMake(LINE_NUMBERS_WIDTH - 2, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        afterLineNumberView.frame = afterFrame;
        [self.scrollView addSubview:afterLineNumberView];

        CGRect fileViewFrame = CGRectMake(PANEL_MARGIN, originY, containerFrame.size.width - (PANEL_MARGIN * 2), linePosition);
        self.frame = fileViewFrame;

        CGRect fileScrollViewFrame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, self.frame.size.width, linePosition);
        self.scrollView.frame = fileScrollViewFrame;
        self.scrollView.contentSize = CGSizeMake(maxLineWidth, linePosition);
    }

    return self;
}

@end
