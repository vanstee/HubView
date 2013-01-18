#import <Foundation/Foundation.h>

@class Line;

@interface LineFactory : NSObject

+ (id)createLineWithRawLine:(NSString *)rawLine;
+ (id)createLineWithRawLine:(NSString *)rawLine andPreviousLine:(Line *)previousLine;
+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines;
+ (Class)lineTypeForRawLine:(NSString *)rawLine;

@end
