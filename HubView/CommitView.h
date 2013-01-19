#import <UIKit/UIKit.h>

@class Commit;

@interface CommitView : UIView <UIWebViewDelegate>

@property (nonatomic, strong) Commit *partialCommit;
@property (nonatomic, strong) Commit *commit;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSMutableArray *commentWebViews;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)displayCommit;
- (void)hideCommit;

@end
