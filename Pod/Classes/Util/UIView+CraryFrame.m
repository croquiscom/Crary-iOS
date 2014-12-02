#import "UIView+CraryFrame.h"

@implementation UIView (CraryFrame)

- (CGSize)cr_size
{
    return self.frame.size;
}

- (void)setCr_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)cr_width
{
    return self.frame.size.width;
}

- (void)setCr_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)cr_height
{
    return self.frame.size.height;
}

- (void)setCr_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)cr_origin
{
    return self.frame.origin;
}

- (void)setCr_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)cr_left
{
    return self.frame.origin.x;
}

- (void)setCr_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)cr_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCr_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)cr_top
{
    return self.frame.origin.y;
}

- (void)setCr_top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)cr_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCr_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)cr_centerX
{
    return self.cr_left + self.cr_width / 2;
}

- (void)setCr_centerX:(CGFloat)centerX
{
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width / 2;
    self.frame = frame;
}

- (CGFloat)cr_centerY
{
    return self.cr_top + self.cr_height / 2;
}

- (void)setCr_centerY:(CGFloat)centerY
{
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height / 2;
    self.frame = frame;
}

@end
