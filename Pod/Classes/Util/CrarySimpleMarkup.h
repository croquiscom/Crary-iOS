#import <UIKit/UIKit.h>

@interface CrarySimpleMarkup : NSObject

+ (NSAttributedString *)parse:(NSString *)str withFont:(UIFont *)font;

@end
