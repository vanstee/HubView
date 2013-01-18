#import <Foundation/Foundation.h>

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;

- (NSInteger)maxLineWidth;
- (id)initWithRawPatch:(NSString *)rawPatch;

@end