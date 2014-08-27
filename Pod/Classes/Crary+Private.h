#import <Foundation/Foundation.h>

#undef NSLocalizedString
#define NSLocalizedString(key, comment) [[Crary bundle] localizedStringForKey:(key) value:@"" table:nil]

@interface Crary : NSObject

+ (NSBundle *)bundle;

@end
