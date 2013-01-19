#import <UIKit/UIKit.h>

@class File;
@class FileView;

@interface FileContentView : UIView

@property (nonatomic, strong) File *file;
@property (nonatomic, weak) FileView *fileView;

@end
