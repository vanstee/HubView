#import <Foundation/Foundation.h>

@interface Line : NSObject

@property (nonatomic, strong) NSNumber *beforeLineNumber;
@property (nonatomic, strong) NSNumber *afterLineNumber;
@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSString *rawLine;

+ (Line *)initWithRawLine:(NSString *)rawLine;

@end
