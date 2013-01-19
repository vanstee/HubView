#import <UIKit/UIKit.h>

#define LINE_NUMBER_VIEW_WIDTH 32

@class File;
@class FileContentView;

@interface LineNumberView : UIView

@property (nonatomic, strong) File *file;
@property (nonatomic, weak) FileContentView *fileContentView;

- (NSString *)lineNumberType;

@end
