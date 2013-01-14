#import "FileView.h"

@implementation FileView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizesSubviews = YES;

        CGRect scrollViewFrame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, self.frame.size.width, 0);
        self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.scrollView.autoresizesSubviews = YES;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
    }

    return self;
}

- (void)setFile:(File *)file
{
    _file = file;
    [super setTitle:file.filename];

    CGRect fileContentViewFrame = CGRectMake(GUTTER_WIDTH + 1, 0, self.frame.size.width - GUTTER_WIDTH + 1, 0);
    FileContentView *fileContentView = [[FileContentView alloc] initWithFrame:fileContentViewFrame];
    fileContentView.file = self.file;
    [self.scrollView addSubview:fileContentView];
    
    CGRect gutterViewFrame = CGRectMake(0, 0, GUTTER_WIDTH, 0);
    GutterView *gutterView = [[GutterView alloc] initWithFrame:gutterViewFrame];
    [gutterView setFileContentViewWidth:fileContentViewFrame.size.width];
    gutterView.file = file;
    [self.scrollView addSubview:gutterView];
    
    CGRect frame = self.frame;
    frame.size.height = PANEL_NAVIGATION_BAR_HEIGHT + fileContentView.frame.size.height;
    self.frame = frame;

    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.size.height = fileContentView.frame.size.height;
    self.scrollView.frame = scrollViewFrame;
    
    CGSize contentSize = CGSizeMake(gutterView.frame.size.width + fileContentView.frame.size.width, fileContentView.frame.size.height);
    self.scrollView.contentSize = contentSize;
}

@end