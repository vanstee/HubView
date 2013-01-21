#import "CommentOrganizer.h"

#import "Comment.h"
#import "File.h"

@implementation CommentOrganizer

+ (NSArray *)commentsWithoutPathAndPosition:(NSArray *)comments
{
    NSMutableArray *commentsArray = [[NSMutableArray alloc] initWithCapacity:comments.count];
    for (Comment *comment in comments) {
        if (!comment.path && !comment.position) { [commentsArray addObject:comment]; }
    }
    return commentsArray;
}

+ (NSDictionary *)commentsByPathAndPosition:(NSArray *)comments
{
    NSMutableDictionary *commentDictionary = [NSMutableDictionary dictionaryWithCapacity:comments.count];
    for (Comment *comment in comments) {
        if (comment.path && comment.position) {
            NSNumber *position = [NSNumber numberWithInteger:comment.position];
            if (!commentDictionary[comment.path]) { commentDictionary[comment.path] = [NSMutableDictionary new]; }
            if (!commentDictionary[comment.path][position]) { commentDictionary[comment.path][position] = [NSMutableArray new]; }
            [commentDictionary[comment.path][position] addObject:comment];
        }
    }

    for (NSString *path in [commentDictionary allKeys]) {
        for (NSNumber *position in [commentDictionary[path] allKeys]) {
            NSArray *commentsForPathAndPosition = commentDictionary[path][position];
            commentDictionary[path][position] = [[[commentsForPathAndPosition sortedArrayUsingSelector:@selector(createdAt)] reverseObjectEnumerator] allObjects];
        }
    }

    return commentDictionary;
}

- (id)initWithComments:(NSArray *)comments
{
    if (self = [self init]) {
        self.comments = comments;
        self.commitLevelComments = [self.class commentsWithoutPathAndPosition:comments];
        self.commentsByPathAndPosition = [self.class commentsByPathAndPosition:comments];
    }
    return self;
}

- (NSDictionary *)commentsForFile:(File *)file
{
    return self.commentsByPathAndPosition[file.filename];
}

- (NSArray *)commentsForFile:(File *)file position:(NSNumber *)position
{
    return self.commentsByPathAndPosition[file.filename][position];
}

@end
