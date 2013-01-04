#import <UIKit/UIKit.h>
#import "LineLabel.h"

#define LINE_NUMBER_MARGIN 6
#define LINE_NUMBER_WIDTH 31

@interface LineNumberLabel : UILabel

- (id)initWithText:(NSString *)text originY:(CGFloat)originY;

@end
