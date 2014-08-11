#import <Foundation/Foundation.h>
typedef void(^UIAlertViewCompleteBlock)(NSInteger index);

@interface UIAlertView (Crary)  <UIAlertViewDelegate>
@property (assign, nonatomic) UIAlertViewCompleteBlock complete;

- (id)initWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle complete:(UIAlertViewCompleteBlock)complete;
- (id)initWithTitle:(NSString*)title message:(NSString*)message firstButtonTitle:(NSString*)firstButtonTitle secondButtonTitle:(NSString*)secondButtonTitle complete:(UIAlertViewCompleteBlock)complete;
@end
