#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "PanelNavigationBar.h"

#define PANEL_MARGIN 20

@interface PanelView : UIView

@property (nonatomic, strong) PanelNavigationBar *navigationBar;

- (void)setTitle:(NSString *)title;

@end