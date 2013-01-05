#import <Foundation/Foundation.h>

@interface Line : NSObject

@property (nonatomic, assign) NSInteger beforeLineNumber;
@property (nonatomic, assign) NSInteger afterLineNumber;
@property (nonatomic, strong) NSString *rawLine;
@property (nonatomic, strong) NSArray *comments;

- (id)initWithRawLine:(NSString *)rawLine;
- (NSInteger)progressBeforeLineNumber;
- (NSInteger)progressAfterLineNumber;
- (UIColor *)textColor;
- (UIColor *)backgroundColor;
- (NSString *)beforeLineNumberString;
- (NSString *)afterLineNumberString;

@end
