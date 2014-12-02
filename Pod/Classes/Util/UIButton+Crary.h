#import <UIKit/UIKit.h>

@interface UIButton (Crary)

+ (UIButton *)cr_buttonWithImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed;
+ (UIButton *)cr_buttonWithBackgroundImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed;

- (void)cr_setImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed;
- (void)cr_setBackgroundImageNormal:(UIImage *)normal andPressed:(UIImage *)pressed;

@end
