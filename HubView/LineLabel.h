#import <UIKit/UIKit.h>
#import "Line.h"
#import "GutterView.h"

#define LINE_HEIGHT 16

@interface LineLabel : UILabel

- (id)initWithLine:(Line *)line originY:(CGFloat)originY width:(CGFloat)width;

@end
