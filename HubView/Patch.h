#import <Foundation/Foundation.h>
#import "File.h"
#import "GutterView.h"
#import "LineFactory.h"

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;

- (NSInteger)maxLineWidth;
- (id)initWithRawPatch:(NSString *)rawPatch;

@end