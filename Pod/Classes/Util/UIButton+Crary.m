#import "UIButton+Crary.h"

@implementation UIButton (Crary)

+ (UIButton *)cr_buttonWithImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normal.size.width, normal.size.height)];
    [button cr_setImageNormal:normal andPressed:pressed];
    return button;
}

+ (UIButton *)cr_buttonWithBackgroundImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, normal.size.width, normal.size.height)];
    [button cr_setBackgroundImageNormal:normal andPressed:pressed];
    return button;
}

- (void)cr_setImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed
{
    [self setImage:normal forState:UIControlStateNormal];
    [self setImage:pressed forState:UIControlStateHighlighted];
}

- (void)cr_setBackgroundImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed
{
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:pressed forState:UIControlStateHighlighted];
}

@end
