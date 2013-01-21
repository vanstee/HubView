#import <Foundation/Foundation.h>

@interface CommentBodyParser : NSObject

+ (id)htmlForMarkdownString:(NSString *)markdownString;

@end
