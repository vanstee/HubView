#import <UIKit/UIKit.h>
#import "Line.h"
#import "LineNumberView.h"

#define LINE_HEIGHT 16

@interface LineLabel : UILabel

@property (nonatomic, strong) Line *line;

@end
