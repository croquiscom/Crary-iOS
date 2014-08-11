#import "UIAlertView+Crary.h"
#import <objc/runtime.h>

@implementation UIAlertView (Crary)

- (id)initWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle complete:(UIAlertViewCompleteBlock)complete
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    self.complete = complete;
    return self;
}
- (id)initWithTitle:(NSString*)title message:(NSString*)message firstButtonTitle:(NSString*)firstButtonTitle secondButtonTitle:(NSString*)secondButtonTitle complete:(UIAlertViewCompleteBlock)complete
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:firstButtonTitle otherButtonTitles:secondButtonTitle, nil];
    self.complete = complete;
    return self;
}

- (UIAlertViewCompleteBlock)complete
{
    return objc_getAssociatedObject(self, @selector(complete));
}

- (void)setComplete:(UIAlertViewCompleteBlock)complete
{
    objc_setAssociatedObject(self, @selector(complete), complete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.complete) {
        self.complete(buttonIndex);
    }
}

@end
