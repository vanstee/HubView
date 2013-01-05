#import "CommitView.h"

@implementation CommitView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = YES;
        self.backgroundColor = [UIColor underPageBackgroundColor];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.scrollView];
    }
    return self;
}

+ (UIView *)createCommentsViewWithComments:(NSArray *)comments color:(UIColor *)color andFileView:(UIView *)fileView
{
    UIColor *greyColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1];
    UIColor *gradientStartColor = [UIColor colorWithRed:247.0/255.0 green:248.0/255.0 blue:250.0/255.0 alpha:1];
    UIColor *gradientEndColor = [UIColor colorWithRed:209.0/255.0 green:212.0/255.0 blue:221.0/255.0 alpha:1];

    NSInteger backgroundWidth = fileView.frame.size.width - GUTTER_WIDTH;
    NSInteger contentWidth = backgroundWidth - (COMMENT_MARGIN * 2);
    NSInteger contentTextWidth = contentWidth - (COMMENT_PADDING * 2);

    UIFont *headerFont = [UIFont fontWithName:@"Helvetica" size:14];
    UIFont *bodyFont = [UIFont fontWithName:@"Helvetica" size:14];

    CGRect backgroundFrame = CGRectMake(0, 0, backgroundWidth, 0);
    UIView *background = [[UIView alloc] initWithFrame:backgroundFrame];
    background.backgroundColor = color;

    NSInteger position = 0;

    for (Comment *comment in comments) {
        CGSize headerTextSize = [comment.user.login sizeWithFont:headerFont constrainedToSize:CGSizeMake(contentTextWidth, 10000)];
        CGSize bodyTextSize = [comment.body sizeWithFont:bodyFont constrainedToSize:CGSizeMake(contentTextWidth, 10000)];
        CGSize headerSize = CGSizeMake(contentWidth, headerTextSize.height + (COMMENT_PADDING * 2));
        CGSize bodySize = CGSizeMake(contentWidth, bodyTextSize.height + (COMMENT_PADDING * 2) - 1);
        CGSize contentSize = CGSizeMake(contentWidth, headerSize.height + bodySize.height);
        CGSize backgroundSize = CGSizeMake(backgroundWidth, contentSize.height + COMMENT_MARGIN);

        backgroundFrame = background.frame;
        backgroundFrame.size.height += backgroundSize.height;
        background.frame = backgroundFrame;

        CGRect headerFrame = CGRectMake(COMMENT_MARGIN, position + COMMENT_MARGIN, contentSize.width, headerSize.height);
        UIView *header = [[UIView alloc] initWithFrame:headerFrame];
        header.layer.borderColor = [greyColor CGColor];
        header.layer.borderWidth = 1;

        CAGradientLayer *gradient = [CAGradientLayer new];
        gradient.frame = header.bounds;
        gradient.colors = @[(id)[gradientStartColor CGColor], (id)[gradientEndColor CGColor]];
        [header.layer insertSublayer:gradient atIndex:0];

        CGRect headerTextFrame = CGRectMake(COMMENT_PADDING, COMMENT_PADDING, contentTextWidth, headerTextSize.height);
        UILabel *headerText = [[UILabel alloc] initWithFrame:headerTextFrame];
        headerText.text = comment.user.login;
        headerText.font = headerFont;
        headerText.backgroundColor = [UIColor clearColor];
        headerText.lineBreakMode = NSLineBreakByWordWrapping;
        headerText.numberOfLines = 0;

        UILabel *headerDate = [[UILabel alloc] initWithFrame:headerTextFrame];
        headerDate.textAlignment = NSTextAlignmentRight;
        headerDate.text = comment.createdAt.distanceOfTimeInWords;
        headerDate.font = headerFont;
        headerDate.backgroundColor = [UIColor clearColor];
        headerDate.lineBreakMode = NSLineBreakByWordWrapping;
        headerDate.numberOfLines = 0;

        CGRect bodyFrame = CGRectMake(COMMENT_MARGIN, position + COMMENT_MARGIN + headerSize.height - 1, bodySize.width, bodySize.height);
        UIView *body = [[UIView alloc] initWithFrame:bodyFrame];
        body.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1];
        body.layer.borderColor = [[UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1] CGColor];
        body.layer.borderWidth = 1;

        CGRect bodyTextFrame = CGRectMake(COMMENT_PADDING, COMMENT_PADDING, contentTextWidth, bodyTextSize.height);
        UILabel *bodyText = [[UILabel alloc] initWithFrame:bodyTextFrame];
        bodyText.text = comment.body;
        bodyText.font = bodyFont;
        bodyText.backgroundColor = [UIColor clearColor];
        bodyText.lineBreakMode = NSLineBreakByWordWrapping;
        bodyText.numberOfLines = 0;

        [header addSubview:headerText];
        [header addSubview:headerDate];
        [body addSubview:bodyText];
        [background addSubview:header];
        [background addSubview:body];

        position += backgroundSize.height;
    }

    backgroundFrame = background.frame;
    backgroundFrame.size.height += COMMENT_MARGIN;
    background.frame = backgroundFrame;

    return background;
}

+ (NSInteger)maxLineWidthInLines:(NSArray *)lines
{
    NSInteger max = 0;
    for (Line *line in lines) {
        NSString *rawLine = [NSString stringWithFormat:@" %@", line.rawLine];
        max = MAX(max, [rawLine sizeWithFont:[UIFont fontWithName:@"Menlo" size:12]].width + GUTTER_WIDTH);
    }
    return max;
}

- (void)setPartialCommit:(Commit *)commit
{
    self.commit = nil;
    self.comments = nil;

    [commit commitWithCompletionBlock:^(Commit *commit) {
        self.commit = commit;
        [self refresh];
    }];

    [commit commentsWithCompletionBlock:^(NSArray *comments) {
        self.comments = comments;
        [self refresh];
    }];
}

- (void)setCommit:(Commit *)commit
{
    if (_comments) { commit.comments = _comments; }
    _commit = commit;
}

- (void)setComments:(NSArray *)comments
{
    if (_commit) { _commit.comments = comments; }
    _comments = comments;
}

- (void)refresh
{
    if (self.commit && self.commit.comments) {
        [self hideCommit];
        [self displayCommit];
    }
}

- (void)displayCommit
{
    NSInteger filePosition = FILE_MARGIN;

    for (File *file in self.commit.files) {
        FileView *fileView = [[FileView alloc] initWithContainerFrame:self.frame originY:filePosition height:(file.patch.lines.count * LINE_HEIGHT) file:file];

        NSInteger lineNumber = 1;
        NSInteger maxLineWidth = MAX(fileView.frame.size.width, [CommitView maxLineWidthInLines:file.patch.lines]);

        NSInteger linePosition = 0;

        GutterView *beforeGutter = [[GutterView alloc] init];
        GutterView *afterGutter = [[GutterView alloc] init];

        for (NSInteger index = 0; index < file.patch.lines.count; index++) {
            Line *line = file.patch.lines[index];

            LineNumberLabel *beforeLineNumber = [[LineNumberLabel alloc] initWithText:line.beforeLineNumberString originY:linePosition];
            [beforeGutter addSubview:beforeLineNumber];

            LineNumberLabel *afterLineNumber = [[LineNumberLabel alloc] initWithText:line.afterLineNumberString originY:linePosition];
            [afterGutter addSubview:afterLineNumber];

            LineLabel *label = [[LineLabel alloc] initWithLine:line originY:linePosition width:maxLineWidth];
            [fileView.scrollView addSubview:label];

            lineNumber++;
            linePosition += LINE_HEIGHT;

            if (line.comments) {
                UIView *commentsView = [CommitView createCommentsViewWithComments:line.comments color:label.backgroundColor andFileView:fileView];
                CGRect commentsViewFrame = commentsView.frame;
                commentsViewFrame.origin.x = GUTTER_WIDTH;
                commentsViewFrame.origin.y = linePosition;
                commentsView.frame = commentsViewFrame;
                [fileView.scrollView addSubview:commentsView];
                linePosition += commentsView.frame.size.height;
            }
        }

        CGRect beforeGutterFrame = CGRectMake(-1, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        beforeGutter.frame = beforeGutterFrame;
        [fileView.scrollView addSubview:beforeGutter];

        CGRect afterGutterFrame = CGRectMake(LINE_NUMBERS_WIDTH - 2, -1, LINE_NUMBERS_WIDTH, linePosition + 2);
        afterGutter.frame = afterGutterFrame;
        [fileView.scrollView addSubview:afterGutter];

        CGRect fileScrollViewFrame = CGRectMake(0, PANEL_NAVIGATION_BAR_HEIGHT, fileView.frame.size.width, linePosition);
        fileView.scrollView.frame = fileScrollViewFrame;
        fileView.scrollView.contentSize = CGSizeMake(maxLineWidth, linePosition);

        [self.scrollView addSubview:fileView];

        filePosition += PANEL_NAVIGATION_BAR_HEIGHT + linePosition + FILE_MARGIN;
    }

    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, filePosition);
    [self addSubview:self.scrollView];
}

- (void)hideCommit
{
    for (UIView *view in self.subviews) { [view removeFromSuperview]; }
}

@end
