#import <Foundation/Foundation.h>
#import "Comment.h"
#import "File.h"

@interface CommentOrganizer : NSObject

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *commitLevelComments;
@property (nonatomic, strong) NSDictionary *commentsByPathAndPosition;

+ (NSArray *)commentsWithoutPathAndPosition:(NSArray *)comments;
+ (NSDictionary *)commentsByPathAndPosition:(NSArray *)comments;
- (id)initWithComments:(NSArray *)comments;
- (NSDictionary *)commentsForFile:(id)file;
- (NSArray *)commentsForFile:(id)file position:(NSNumber *)position;

@end
