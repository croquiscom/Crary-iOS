#import <Foundation/Foundation.h>

typedef void(^UIAlertViewEndBlock)(NSInteger index);

@interface UIAlertViewWithButton : UIAlertView <UIAlertViewDelegate>

+ (void)showWithOkButton:(NSString*)title message:(NSString*)message complete:(UIAlertViewEndBlock)complete;
+ (void)showWithTwoButton:(NSString*)title message:(NSString*)message btnFirst:(NSString*)btnFirst btnSecond:(NSString*)btnSecond complete:(UIAlertViewEndBlock)complete;

@end
