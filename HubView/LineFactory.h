#import <Foundation/Foundation.h>
#import "Line.h"
#import "AdditionLine.h"
#import "ContextLine.h"
#import "DeletionLine.h"
#import "RangeLine.h"

@interface LineFactory : NSObject

+ (id)createLineWithRawLine:(NSString *)rawLine;

+ (NSArray *)createLinesWithRawLines:(NSArray *)rawLines;

@end
