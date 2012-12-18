#import "Line.h"

@interface RangeLine : Line

@property (nonatomic, strong) NSNumber *beforeStartingLineNumber;
@property (nonatomic, strong) NSNumber *beforeNumberOfLines;
@property (nonatomic, strong) NSNumber *afterStartingLineNumber;
@property (nonatomic, strong) NSNumber *afterNumberOfLines;

@end
