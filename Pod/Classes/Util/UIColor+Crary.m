#import "UIColor+Crary.h"

@implementation UIColor (Crary)

+ (UIColor *)cr_colorWithHex:(NSInteger)hex
{
    return [self cr_colorWithHex:hex alpha:1];
}

+ (UIColor *)cr_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    CGFloat r = (CGFloat)((hex >> 16) & 0xff) / 255.0f;
    CGFloat g = (CGFloat)((hex >> 8) & 0xff) / 255.0f;
    CGFloat b = (CGFloat)(hex & 0xff) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
