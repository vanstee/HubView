#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define PANEL_MARGIN 20
#define PANEL_HEADER_HEIGHT 44

@interface PanelView : UIView

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height;

@end
