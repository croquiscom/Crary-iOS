#import "Crary+Private.h"

@implementation Crary

+ (NSBundle *)bundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Crary" ofType:@"bundle"]];
        if (bundle==nil) {
            bundle = [NSBundle bundleForClass:[Crary self]];
        }
    });
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    for (NSString *language in array) {
        NSString *path = [bundle pathForResource:language ofType:@"lproj"];
        if (path) {
            return [NSBundle bundleWithPath:path];
        }
    }
    return bundle;
}

@end
