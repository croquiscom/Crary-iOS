#import "UIAlertViewWithButton.h"

@interface UIAlertViewWithButton ()
@property (copy, nonatomic) UIAlertViewEndBlock complete;
@end
@implementation UIAlertViewWithButton
+ (void)showWithOkButton:(NSString*)title message:(NSString*)message complete:(void(^)(NSInteger index))complete
{
    UIAlertViewWithButton *alert = [[UIAlertViewWithButton alloc] initWithOkButton:title message:message complete:complete];
    [alert show];
}
+ (void)showWithTwoButton:(NSString*)title message:(NSString*)message btnFirst:(NSString*)btnFirst btnSecond:(NSString*)btnSecond complete:(void(^)(NSInteger index))complete
{
    UIAlertViewWithButton *alert = [[UIAlertViewWithButton alloc] initWithTwoButton:title message:message btnFirst:btnFirst btnSecond:btnSecond complete:complete];
    [alert show];
}

- (id)initWithOkButton:(NSString*)title message:(NSString*)message complete:(void(^)(NSInteger index))complete
{
    self.complete = complete;
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"common_ok", @"") otherButtonTitles:nil];
    return self;
}
- (id)initWithTwoButton:(NSString*)title message:(NSString*)message btnFirst:(NSString*)btnFirst btnSecond:(NSString*)btnSecond complete:(void(^)(NSInteger index))complete
{
    self.complete = complete;
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:btnFirst otherButtonTitles:btnSecond, nil];
    return self;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.complete)
    {
        self.complete(buttonIndex);
        self.complete = nil;
    }
}

@end
