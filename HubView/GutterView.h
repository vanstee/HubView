#import <UIKit/UIKit.h>

#define GUTTER_WIDTH 60

@class AfterLineNumberView;
@class BeforeLineNumberView;
@class File;
@class FileContentView;

@interface GutterView : UIView

@property (nonatomic, strong) AfterLineNumberView *afterLineNumberView;
@property (nonatomic, strong) BeforeLineNumberView *beforeLineNumberView;
@property (nonatomic, weak) FileContentView *fileContentView;

- (id)initWithFrame:(CGRect)frame;
- (void)setFile:(File *)file;

@end
