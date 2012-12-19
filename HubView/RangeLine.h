#import "Line.h"

@interface RangeLine : Line

@property (nonatomic, assign) NSInteger beforeStartingLineNumber;
@property (nonatomic, assign) NSInteger beforeNumberOfLines;
@property (nonatomic, assign) NSInteger afterStartingLineNumber;
@property (nonatomic, assign) NSInteger afterNumberOfLines;

@end
