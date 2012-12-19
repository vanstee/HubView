#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Commit.h"

#define FILE_MARGIN 20
#define FILE_HEADER_HEIGHT 44
#define LINE_HEIGHT 16
#define LINE_NUMBERS_MARGIN 6
#define LINE_NUMBERS_WIDTH 30.5
#define GUTTER_WIDTH 60

@interface CommitView : UIView

@property (nonatomic, strong) Commit *commit;

+ (UIScrollView *)createScrollViewWithCommitView:(CommitView *)commitView;
+ (UIView *)createFileViewWithCommitView:(CommitView *)commitView filePosition:(NSInteger)filePosition andFile:(File *)file;
+ (UINavigationBar *)createFileNavigationBarWithFileView:(UIView *)fileView andFile:(File *)file;
+ (UIScrollView *)createFileScrollViewWithFileView:(UIView *)fileView;
+ (UILabel *)createLineLabelWithLinePosition:(NSInteger)linePosition maxLineWidth:(NSInteger)maxLineWidth andLine:(Line *)line;
+ (NSInteger)maxLineWidthInLines:(NSArray *)lines;
- (void)displayCommit;
- (void)hideCommit;

@end
