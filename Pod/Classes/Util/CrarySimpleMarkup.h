#import <UIKit/UIKit.h>

@interface CrarySimpleMarkup : NSObject

+ (NSAttributedString *)parse:(NSString *)str withFont:(UIFont *)font;

@end

@interface UILabel (CrarySimpleMarkup)

@property (copy, nonatomic) NSString *cr_simpleMarkupText;
- (NSString *)cr_simpleMarkupText UNAVAILABLE_ATTRIBUTE; // no getter

@end
