#import <Foundation/Foundation.h>
#import "File.h"
#import "LineFactory.h"

@interface Patch : NSObject

@property (nonatomic, strong) NSArray *lines;

- (id)initWithRawPatch:(NSString *)rawPatch;

@end