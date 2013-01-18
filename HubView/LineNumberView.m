#import "LineNumberView.h"

#import "CommentThreadView.h"
#import "File.h"
#import "Line.h"
#import "LineLabel.h"
#import "LineNumberLabel.h"
#import "Patch.h"
#import <QuartzCore/QuartzCore.h>

@implementation LineNumberView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor lineNumberViewBackgroundColor];
        self.layer.borderColor = [UIColor lineNumberViewBorderColor].CGColor;
        self.layer.borderWidth = 1;
    }

    return self;
}

- (NSString *)lineNumberType
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

- (void)setFile:(File *)file
{
    _file = file;

    CGFloat linePosition = 0;
    
    for (Line *line in file.patch.lines) {
        CGRect lineNumberLabelFrame = CGRectMake(LINE_NUMBER_WIDTH_MARGIN, linePosition + LINE_NUMBER_HEIGHT_MARGIN, LINE_NUMBER_WIDTH - (LINE_NUMBER_WIDTH_MARGIN * 2), LINE_HEIGHT);
        LineNumberLabel *label = [[LineNumberLabel alloc] initWithFrame:lineNumberLabelFrame];
        label.text = [line valueForKey:self.lineNumberType];
        [self addSubview:label];
        
        linePosition += LINE_HEIGHT;
        
        if (line.comments) {
            CGRect commentThreadViewFrame = CGRectMake(0, 0, self.fileContentViewWidth, 0);
            CommentThreadView *commentThreadView = [[CommentThreadView alloc] initWithFrame:commentThreadViewFrame];
            commentThreadView.comments = line.comments;
            linePosition += commentThreadView.frame.size.height;
        }
    }

    CGRect frame = self.frame;
    frame.size.height = linePosition;
    self.frame = frame;
}

@end
