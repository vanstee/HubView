#import <UIKit/UIKit.h>

#define LINE_NUMBER_VIEW_WIDTH 32

@class File;

@interface LineNumberView : UIView

@property (nonatomic, strong) File *file;
@property CGFloat fileContentViewWidth;

- (NSString *)lineNumberType;

@end
