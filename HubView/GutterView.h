#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Line.h"

#define GUTTER_WIDTH 60

@interface GutterView : UIView

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *lines;

@end
