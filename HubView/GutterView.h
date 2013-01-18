#import <UIKit/UIKit.h>

#define GUTTER_WIDTH 60

@class AfterLineNumberView;
@class BeforeLineNumberView;
@class File;

@interface GutterView : UIView

@property (nonatomic, strong) AfterLineNumberView *afterLineNumberView;
@property (nonatomic, strong) BeforeLineNumberView *beforeLineNumberView;

- (id)initWithFrame:(CGRect)frame;
- (void)setFile:(File *)file;
- (void)setFileContentViewWidth:(CGFloat)fileContentViewWidth;

@end
