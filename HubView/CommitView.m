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

+ (UILabel *)createLineLabelWithLinePosition:(NSInteger)linePosition maxLineWidth:(NSInteger)maxLineWidth andLine:(Line *)line
{
    CGRect labelFrame = CGRectMake(0, linePosition, maxLineWidth, LINE_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.font = [UIFont fontWithName:@"CourierNewPSMT" size:14];

    label.text = line.rawLine;
    label.textColor = line.textColor;
    label.backgroundColor = line.backgroundColor;

    return label;
}

+ (NSInteger)maxLineWidthInLines:(NSArray *)lines
{
    NSInteger max = 0;
    for (Line *line in lines) {
        max = MAX(max, [line.rawLine sizeWithFont:[UIFont fontWithName:@"CourierNewPSMT" size:14]].width);
    }
    return max;
}

- (void)setCommit:(Commit *)commit
{
    if (_commit != commit)
    {
        [commit commitWithCompletionBlock:^(Commit *commit) {
            _commit = commit;
            [self hideCommit];
            [self displayCommit];
        }];
    }
}

- (void)displayCommit
{
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor underPageBackgroundColor];

    UIScrollView *scrollView = [CommitView createScrollViewWithCommitView:self];

    NSInteger filePosition = FILE_MARGIN;

    for (File *file in self.commit.files) {
        UIView *fileView = [CommitView createFileViewWithCommitView:self filePosition:filePosition andFile:file];

        NSInteger lineNumber = 1;
        NSInteger maxLineWidth = MAX(fileView.frame.size.width, [CommitView maxLineWidthInLines:file.patch.lines]);

        UINavigationBar *navigationBar = [CommitView createFileNavigationBarWithFileView:fileView andFile:file];
        [fileView addSubview:navigationBar];

        NSInteger linePosition = FILE_HEADER_HEIGHT;

        UIScrollView *fileScrollView = [CommitView createFileScrollViewWithFileView:fileView];

        for (Line *line in file.patch.lines) {
            UILabel *label = [CommitView createLineLabelWithLinePosition:linePosition maxLineWidth:maxLineWidth andLine:line];
            [fileScrollView addSubview:label];

            lineNumber++;
            linePosition += LINE_HEIGHT;
        }

        fileScrollView.contentSize = CGSizeMake(maxLineWidth, linePosition);
        [fileView addSubview:fileScrollView];

        [scrollView addSubview:fileView];
        
        filePosition += (file.patch.lines.count * LINE_HEIGHT) + FILE_HEADER_HEIGHT + FILE_MARGIN;
    }

    scrollView.contentSize = CGSizeMake(self.frame.size.width, filePosition);
    [self addSubview:scrollView];
}

- (void)hideCommit
{
    for (UIView *view in self.subviews) { [view removeFromSuperview]; }
}

@end
