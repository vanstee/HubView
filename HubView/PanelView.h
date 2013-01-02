#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "PanelNavigationBar.h"

#define PANEL_MARGIN 20

@interface PanelView : UIView

- (id)initWithContainerFrame:(CGRect)containerFrame originY:(CGFloat)originY height:(CGFloat)height title:(NSString *)title;

@end
