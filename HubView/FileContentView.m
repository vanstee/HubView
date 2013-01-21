#import "FileContentView.h"

#import "CommentThreadView.h"
#import "File.h"
#import "Line.h"
#import "LineLabel.h"
#import "Patch.h"

@implementation FileContentView

- (void)setFile:(File *)file
{
    _file = file;

    CGFloat maxLineWidth = MAX(file.patch.maxLineWidth, self.frame.size.width);
    CGFloat linePosition = 0;

    for (Line *line in file.patch.lines) {
        CGRect lineLabelFrame = CGRectMake(0, linePosition, maxLineWidth, LINE_HEIGHT);
        LineLabel *label = [[LineLabel alloc] initWithFrame:lineLabelFrame];
        label.line = line;
        [self addSubview:label];
        
        linePosition += label.frame.size.height;
        
        if (line.comments && line.comments.count) {
            CGRect commentThreadViewFrame = CGRectMake(0, linePosition, maxLineWidth, 0);
            CommentThreadView *commentThreadView = [[CommentThreadView alloc] initWithFrame:commentThreadViewFrame];
            commentThreadView.fileContentView = self;
            commentThreadView.backgroundColor = label.backgroundColor;
            commentThreadView.comments = line.comments;
            [self addSubview:commentThreadView];
            linePosition += commentThreadView.frame.size.height;
        }
    }

    CGRect frame = self.frame;
    frame.size.height = linePosition;
    frame.size.width = maxLineWidth;
    self.frame = frame;
}

@end