#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Line.h"

#define LINE_NUMBER_VIEW_WIDTH 60

@interface LineNumberView : UIView

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *lines;

@end
