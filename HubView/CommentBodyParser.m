#import "CommentBodyParser.h"

#import <GHMarkdownParser.h>

@implementation CommentBodyParser

+ (id)htmlForMarkdownString:(NSString *)markdownString
{
    NSString *htmlString = markdownString.HTMLStringFromMarkdown;
    return [@[self.htmlHeader, htmlString, self.htmlFooter] componentsJoinedByString:@"\n"];
}

+ (NSString *)htmlHeader
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MarkdownHeader" ofType:@"html"];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)htmlFooter
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MarkdownFooter" ofType:@"html"];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

@end
