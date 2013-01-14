#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Commit.h"
#import "CommitLevelCommentThreadView.h"
#import "FileView.h"

@class Comment;

@interface CommitView : UIView

@property (nonatomic, strong) Commit *partialCommit;
@property (nonatomic, strong) Commit *commit;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)displayCommit;
- (void)hideCommit;

@end
