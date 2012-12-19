#import <Foundation/Foundation.h>
#import "Line.h"
#import "AdditionLine.h"
#import "CommentLine.h"
#import "ContextLine.h"
#import "DeletionLine.h"
#import "RangeLine.h"

@interface LineFactory : NSObject

+ (id)createLineWithRawLine:(NSString *)rawLine;
+ (id)createLineWithRawLine:(NSString *)rawLine andPreviousLine:(Line *)previousLine;
+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines;
+ (Class)lineTypeForRawLine:(NSString *)rawLine;

@end
