#import <UIKit/UIKit.h>

@interface HVTextFieldCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) UITextField *textField;

@end
