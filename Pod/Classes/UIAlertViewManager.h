#import <Foundation/Foundation.h>
#import "UIAlertView+Crary.h"

@interface UIAlertViewManager : NSObject

+ (void)showWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle complete:(UIAlertViewCompleteBlock)complete;
+ (void)showWithTitle:(NSString*)title message:(NSString*)message firstButtonTitle:(NSString*)firstButtonTitle secondButtonTitle:(NSString*)secondButtonTitle complete:(UIAlertViewCompleteBlock)complete;

@end
