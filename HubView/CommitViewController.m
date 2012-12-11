#import "CommitViewController.h"

@implementation CommitViewController

- (void)setCommit:(Commit *)commit
{
    if (_commit != commit)
    {
        _commit = commit;
    }
}

@end
