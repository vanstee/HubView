#import <Foundation/Foundation.h>
#import "File.h"
#import "LineNumberView.h"
#import "LineFactory.h"

@class LineNumberView;

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;

- (NSInteger)maxLineWidth;
- (id)initWithRawPatch:(NSString *)rawPatch;

@end