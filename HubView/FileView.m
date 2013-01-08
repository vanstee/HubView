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

        GutterView *beforeGutter = [[GutterView alloc] init];
        GutterView *afterGutter = [[GutterView alloc] init];

        for (Line *line in file.patch.lines) {
            LineNumberLabel *beforeLineNumber = [[LineNumberLabel alloc] initWithText:line.beforeLineNumberString originY:linePosition];
            [beforeGutter addSubview:beforeLineNumber];

            LineNumberLabel *afterLineNumber = [[LineNumberLabel alloc] initWithText:line.afterLineNumberString originY:linePosition];
            [afterGutter addSubview:afterLineNumber];

            LineLabel *label = [[LineLabel alloc] initWithLine:line originY:linePosition width:maxLineWidth];
            [self.scrollView addSubview:label];

            linePosition += label.frame.size.height;

            if (line.comments) {
                UIView *commentsView = [CommitView createCommentsViewWithComments:line.comments color:label.backgroundColor andFileView:self];
                CGRect commentsViewFrame = commentsView.frame;
                commentsViewFrame.origin.x = GUTTER_WIDTH;
                commentsViewFrame.origin.y = linePosition;
                commentsView.frame = commentsViewFrame;
                [self.scrollView addSubview:commentsView];
                linePosition += commentsView.frame.size.height;
            }
        }

        CGRect beforeGutterFrame = CGRectMake(-1, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        beforeGutter.frame = beforeGutterFrame;
        [self.scrollView addSubview:beforeGutter];

        CGRect afterGutterFrame = CGRectMake(LINE_NUMBERS_WIDTH - 2, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        afterGutter.frame = afterGutterFrame;
        [self.scrollView addSubview:afterGutter];

        CGRect fileViewFrame = CGRectMake(PANEL_MARGIN, originY, containerFrame.size.width - (PANEL_MARGIN * 2), linePosition);
        self.frame = fileViewFrame;

        CGRect fileScrollViewFrame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, self.frame.size.width, linePosition);
        self.scrollView.frame = fileScrollViewFrame;
        self.scrollView.contentSize = CGSizeMake(maxLineWidth, linePosition);
    }

    return self;
}

@end
