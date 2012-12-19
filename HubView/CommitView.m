#import "CommitView.h"

@implementation CommitView

- (void)setCommit:(Commit *)commit
{
    if (_commit != commit)
    {
        [commit commitWithCompletionBlock:^(Commit *commit) {
            _commit = commit;
        }];

        UITextView *diff = [[UITextView alloc] initWithFrame:self.frame];
        NSArray *arrayOfArrays = [[[commit.files valueForKey:@"patch"] valueForKey:@"lines"] valueForKey:@"formattedLine"];
        NSMutableArray *lines = [NSMutableArray arrayWithCapacity:arrayOfArrays.count];
        for (NSArray *array in arrayOfArrays) { [lines addObjectsFromArray:array]; }
        diff.text = [lines componentsJoinedByString:@"\n"];
        
        [self addSubview:diff];
    }
}

@end
