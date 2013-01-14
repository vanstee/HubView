#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "CommentThreadView.h"
#import "File.h"
#import "LineNumberLabel.h"

#define LINE_NUMBER_VIEW_WIDTH 32

@class File;

@interface LineNumberView : UIView

@property (nonatomic, strong) File *file;
@property CGFloat fileContentViewWidth;

- (NSString *)lineNumberType;

@end
