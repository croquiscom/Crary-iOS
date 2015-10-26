#import "UIView+Crary.h"

@implementation UIView (Crary)

- (UIColor *)cr_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setCr_borderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)cr_borderWidth {
    return self.layer.borderWidth;
}

- (void)setCr_borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)cr_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCr_cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (UIColor *)cr_layerBGColor {
    return [UIColor colorWithCGColor:self.layer.backgroundColor];
}

- (void)setCr_layerBGColor:(UIColor *)cr_layerBGColor {
    self.layer.backgroundColor = cr_layerBGColor.CGColor;
}

@end
