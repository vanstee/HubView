#import <UIKit/UIKit.h>

#define LINE_HEIGHT 16
#define LINE_NUMBER_MARGIN 6
#define LINE_NUMBER_WIDTH 31

@interface LineNumberLabel : UILabel

- (id)initWithText:(NSString *)text originY:(CGFloat)originY;

@end
