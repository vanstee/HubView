#import <Foundation/Foundation.h>

@class File;

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, weak) File *file;

- (NSInteger)maxLineWidth;
- (id)initWithRawPatch:(NSString *)rawPatch;

@end