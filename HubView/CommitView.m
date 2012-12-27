#import "CommitView.h"

@implementation CommitView

+ (UIScrollView *)createScrollViewWithCommitView:(CommitView *)commitView
{
    CGRect scrollViewFrame = CGRectMake(0, 0, commitView.frame.size.width, commitView.frame.size.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return scrollView;
}

+ (UIView *)createFileViewWithCommitView:(CommitView *)commitView filePosition:(NSInteger)filePosition andFile:(File *)file
{
    CGRect viewFrame = CGRectMake(FILE_MARGIN, filePosition, commitView.frame.size.width - (FILE_MARGIN * 2), (file.patch.lines.count * LINE_HEIGHT) + FILE_HEADER_HEIGHT);
    UIView *fileView = [[UIView alloc] initWithFrame:viewFrame];
    fileView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    fileView.backgroundColor = [UIColor whiteColor];
    fileView.layer.masksToBounds = NO;
    fileView.layer.cornerRadius = 0;
    fileView.layer.shadowOffset = CGSizeMake(0, 1);
    fileView.layer.shadowRadius = 5;
    fileView.layer.shadowOpacity = 0.5;
    return fileView;
}

+ (UINavigationBar *)createFileNavigationBarWithFileView:(UIView *)fileView andFile:(File *)file
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, fileView.frame.size.width, FILE_HEADER_HEIGHT)];
    navigationBar.layer.masksToBounds = NO;
    navigationBar.layer.cornerRadius = 3;
    navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:file.filename];
    [navigationBar pushNavigationItem:navigationItem animated:NO];

    return navigationBar;
}

+ (UIScrollView *)createFileScrollViewWithFileView:(UIView *)fileView
{
    CGRect fileScrollViewFrame = CGRectMake(0, 0, fileView.frame.size.width, fileView.frame.size.height);
    UIScrollView *fileScrollView = [[UIScrollView alloc] initWithFrame:fileScrollViewFrame];
    fileScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    fileScrollView.bounces = NO;
    return fileScrollView;
}

+ (UIView *)createGutterWithFileView:(UIView *)fileView andGutterWidth:(NSInteger)gutterWidth
{
    CGRect gutterFrame = CGRectMake(gutterWidth, FILE_HEADER_HEIGHT - 1, LINE_NUMBERS_WIDTH, fileView.frame.size.height);
    UIView *gutter = [[UIView alloc] initWithFrame:gutterFrame];
    gutter.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:245.0/255.0 blue:248.0/255.0 alpha:1];
    gutter.layer.borderColor = [UIColor colorWithRed:182.0/255.0 green:187.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    gutter.layer.borderWidth = 1;
    return gutter;
}

+ (UILabel *)createLineNumberWithLinePosition:(NSInteger)linePosition gutterPosition:(NSInteger)gutterPosition andLineNumber:(NSString *)lineNumberString
{
    CGRect lineNumberFrame = CGRectMake(gutterPosition + LINE_NUMBERS_MARGIN, linePosition, LINE_NUMBERS_WIDTH - (LINE_NUMBERS_MARGIN * 2), LINE_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:lineNumberFrame];
    label.text = lineNumberString;
    label.textColor = [UIColor colorWithRed:172.0/255.0 green:177.0/255.0 blue:194.0/255.0 alpha:1];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Menlo" size:10];
    label.textAlignment = NSTextAlignmentRight;
    if ([label.text isEqualToString:@"..."]) {
        lineNumberFrame.origin.y = linePosition - (LINE_HEIGHT / 8.0);
        label.frame = lineNumberFrame;
    }
    return label;
}

+ (UILabel *)createLineLabelWithLinePosition:(NSInteger)linePosition maxLineWidth:(NSInteger)maxLineWidth andLine:(Line *)line
{
    CGRect labelFrame = CGRectMake(GUTTER_WIDTH, linePosition, maxLineWidth, LINE_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.font = [UIFont fontWithName:@"Menlo" size:12];
    label.text = [NSString stringWithFormat:@" %@", line.rawLine];
    label.textColor = line.textColor;
    label.backgroundColor = line.backgroundColor;
    return label;
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

- (void)setCommit:(Commit *)commit
{
    if (_commit != commit)
    {
        [commit commitWithCompletionBlock:^(Commit *commit) {
            _commit = commit;

            [self.commit commentsWithCompletionBlock:^(NSArray *comments) {
                self.commit.comments = comments;
                [self refresh];
            }];
        }];
    }
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
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor underPageBackgroundColor];

    UIScrollView *scrollView = [CommitView createScrollViewWithCommitView:self];

    NSInteger filePosition = FILE_MARGIN;

    NSDictionary *commentsByPathAndPosition = self.commit.commentsByPathAndPosition;

    for (File *file in self.commit.files) {
        UIView *fileView = [CommitView createFileViewWithCommitView:self filePosition:filePosition andFile:file];

        NSInteger lineNumber = 1;
        NSInteger maxLineWidth = MAX(fileView.frame.size.width, [CommitView maxLineWidthInLines:file.patch.lines]);

        NSInteger linePosition = FILE_HEADER_HEIGHT;

        UIScrollView *fileScrollView = [CommitView createFileScrollViewWithFileView:fileView];

        UIView *beforeGutter = [CommitView createGutterWithFileView:fileView andGutterWidth:0];
        UIView *afterGutter = [CommitView createGutterWithFileView:fileView andGutterWidth:LINE_NUMBERS_WIDTH - 1];

        [fileScrollView addSubview:beforeGutter];
        [fileScrollView addSubview:afterGutter];

        for (NSInteger index = 0; index < file.patch.lines.count; index++) {
            Line *line = file.patch.lines[index];

            UILabel *beforeLineNumber = [CommitView createLineNumberWithLinePosition:linePosition gutterPosition:0 andLineNumber:line.beforeLineNumberString];
            [fileScrollView addSubview:beforeLineNumber];

            UILabel *afterLineNumber = [CommitView createLineNumberWithLinePosition:linePosition gutterPosition:LINE_NUMBERS_WIDTH - 1 andLineNumber:line.afterLineNumberString];
            [fileScrollView addSubview:afterLineNumber];

            UILabel *label = [CommitView createLineLabelWithLinePosition:linePosition maxLineWidth:maxLineWidth andLine:line];
            [fileScrollView addSubview:label];

            lineNumber++;
            linePosition += LINE_HEIGHT;

            NSArray *comments = commentsByPathAndPosition[file.filename][[NSNumber numberWithInteger:index]];
            if (comments) {
                UIView *commentsView = [CommitView createCommentsViewWithComments:comments color:label.backgroundColor andFileView:fileView];
                CGRect commentsViewFrame = commentsView.frame;
                commentsViewFrame.origin.x = GUTTER_WIDTH;
                commentsViewFrame.origin.y = linePosition;
                commentsView.frame = commentsViewFrame;
                [fileScrollView addSubview:commentsView];
                linePosition += commentsView.frame.size.height;
            }
        }

        CGRect beforeGutterFrame = beforeGutter.frame;
        beforeGutterFrame.size.height = linePosition;
        beforeGutter.frame = beforeGutterFrame;

        CGRect afterGutterFrame = afterGutter.frame;
        afterGutterFrame.size.height = linePosition;
        afterGutter.frame = afterGutterFrame;

        CGRect fileScrollViewFrame = fileScrollView.frame;
        fileScrollViewFrame.size.height = linePosition;
        fileScrollView.frame = fileScrollViewFrame;

        fileScrollView.contentSize = CGSizeMake(maxLineWidth, linePosition);
        [fileView addSubview:fileScrollView];

        UINavigationBar *navigationBar = [CommitView createFileNavigationBarWithFileView:fileView andFile:file];
        [fileView addSubview:navigationBar];

        [scrollView addSubview:fileView];

        filePosition += linePosition + FILE_MARGIN;
    }

    scrollView.contentSize = CGSizeMake(self.frame.size.width, filePosition);
    [self addSubview:scrollView];
}

- (void)hideCommit
{
    for (UIView *view in self.subviews) { [view removeFromSuperview]; }
}

@end
