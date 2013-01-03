#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Commit.h"
#import "FileView.h"
#import "GutterView.h"

#define FILE_MARGIN 20
#define FILE_HEADER_HEIGHT 44
#define LINE_HEIGHT 16
#define LINE_NUMBERS_MARGIN 6
#define LINE_NUMBERS_WIDTH 31
#define GUTTER_WIDTH 60
#define COMMENT_MARGIN 10
#define COMMENT_PADDING 10

@interface CommitView : UIView

extern UIColor *blackColor;
extern UIColor *gradientStartColor;
extern UIColor *gradientEndColor;

@property (nonatomic, strong) Commit *commit;
@property (nonatomic, strong) UIScrollView *scrollView;

+ (UILabel *)createLineNumberWithLinePosition:(NSInteger)linePosition lineNumber:(NSString *)lineNumberString;
+ (UILabel *)createLineLabelWithLinePosition:(NSInteger)linePosition maxLineWidth:(NSInteger)maxLineWidth andLine:(Line *)line;
+ (UIView *)createCommentsViewWithComments:(NSArray *)comments color:(UIColor *)color andFileView:(UIView *)fileView;
+ (NSInteger)maxLineWidthInLines:(NSArray *)lines;
- (void)displayCommit;
- (void)hideCommit;

@end
