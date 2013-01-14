#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Commit.h"
#import "FileView.h"
#import "LineNumberView.h"
#import "LineLabel.h"
#import "LineNumberLabel.h"

@class Comment;

@interface CommitView : UIView

extern UIColor *blackColor;
extern UIColor *gradientStartColor;
extern UIColor *gradientEndColor;

@property (nonatomic, strong) Commit *partialCommit;
@property (nonatomic, strong) Commit *commit;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)displayCommit;
- (void)hideCommit;

@end
