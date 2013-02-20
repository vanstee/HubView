#import <Foundation/Foundation.h>

@interface CommentBodyParser : NSObject

+ (id)flavoredHtmlForMarkdownString:(NSString *)markdownString;

@end
