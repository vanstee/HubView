#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define LINE_NUMBERS_WIDTH 31
#define GUTTER_WIDTH 60

@interface GutterView : UIView

@property (nonatomic, strong) NSArray *lines;

@end
