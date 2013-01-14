#import <UIKit/UIKit.h>
#import "File.h"
#import "Line.h"
#import "BeforeLineNumberView.h"
#import "AfterLineNumberView.h"

#define GUTTER_WIDTH 60

@interface GutterView : UIView

@property (nonatomic, strong) BeforeLineNumberView *beforeLineNumberView;
@property (nonatomic, strong) AfterLineNumberView *afterLineNumberView;

- (id)initWithFrame:(CGRect)frame;
- (void)setFile:(File *)file;
- (void)setFileContentViewWidth:(CGFloat)fileContentViewWidth;

@end
