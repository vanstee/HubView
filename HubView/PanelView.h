#import <UIKit/UIKit.h>

#define PANEL_MARGIN 20

@class PanelNavigationBar;

@interface PanelView : UIView

@property (nonatomic, strong) PanelNavigationBar *navigationBar;

- (void)setTitle:(NSString *)title;

@end