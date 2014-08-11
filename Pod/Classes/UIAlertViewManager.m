#import "UIAlertViewManager.h"

@implementation UIAlertViewManager

+ (void)showWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle complete:(UIAlertViewCompleteBlock)complete
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message buttonTitle:buttonTitle complete:complete];
    [alertView show];
}

+ (void)showWithTitle:(NSString*)title message:(NSString*)message firstButtonTitle:(NSString*)firstButtonTitle secondButtonTitle:(NSString*)secondButtonTitle complete:(UIAlertViewCompleteBlock)complete
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message firstButtonTitle:firstButtonTitle secondButtonTitle:secondButtonTitle complete:complete];
    [alertView show];
}

@end
