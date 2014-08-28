#import <Foundation/Foundation.h>

#define _T(key) [[Crary bundle] localizedStringForKey:(key) value:@"" table:nil]

@interface Crary : NSObject

+ (NSBundle *)bundle;

@end
