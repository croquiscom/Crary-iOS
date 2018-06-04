#import "CraryMessageBox.h"
#import "Crary+Private.h"

@interface CraryMessageBoxAlertView : UIAlertView <UIAlertViewDelegate>
@property (nonatomic, copy) void (^done)(NSInteger index);
@end

@implementation CraryMessageBoxAlertView
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles done:(void (^)(NSInteger index))done
{
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        for (NSString *title in otherButtonTitles) {
            [self addButtonWithTitle:title];
        }
        self.delegate = self;
        self.done = done;
    }
    return self;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.done) {
        self.done(buttonIndex);
    }
}
@end

@implementation CraryMessageBox

//----------------------------------------
#pragma mark - alert

+ (void)alert:(NSString *)message
{
    [self alert:message done:nil];
}

+ (void)alert:(NSString *)message done:(void (^)(void))done
{
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self alert:message title:title done:done];
}

+ (void)alert:(NSString *)message title:(NSString *)title
{
    [self alert:message title:title done:nil];
}

+ (void)alert:(NSString *)message title:(NSString *)title done:(void (^)(void))done
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self alert:vc message:message title:title done:done];
}

//----------------------------------------
#pragma mark - alert with ViewController

+ (void)alert:(UIViewController *)vc message:(NSString *)message {
    [self alert:vc message:message done:nil];
}

+ (void)alert:(UIViewController *)vc message:(NSString *)message done:(void (^)(void))done {
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self alert:vc message:message title:title done:done];
}

+ (void)alert:(UIViewController *)vc message:(NSString *)message title:(NSString *)title {
    [self alert:vc message:message title:title done:nil];
}

+ (void)alert:(UIViewController *)vc message:(NSString *)message title:(NSString *)title done:(void (^)(void))done {
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:_T(@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (done) {
                done();
            }
        }]];
        [vc presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[CraryMessageBoxAlertView alloc] initWithTitle:title message:message cancelButtonTitle:_T(@"OK") otherButtonTitles:@[] done:^(NSInteger index) {
            if (done) {
                done();
            }
        }];
        [alert show];
    }
}

//----------------------------------------
#pragma mark - confirm

+ (void)confirm:(NSString *)message yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL yes_selected))done
{
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self confirm:message title:title yes:yes no:no done:done];
}

+ (void)confirm:(NSString *)message title:(NSString *)title yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL yes_selected))done
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self confirm:vc message:message title:title yes:yes no:no done:done];
}

+ (void)confirmOkCancel:(NSString *)message done:(void (^)(BOOL yes_selected))done
{
    [self confirm:message yes:_T(@"OK") no:_T(@"Cancel") done:done];
}

+ (void)confirmOkCancel:(NSString *)message title:(NSString *)title done:(void (^)(BOOL yes_selected))done
{
    [self confirm:message title:title yes:_T(@"OK") no:_T(@"Cancel") done:done];
}

+ (void)confirmYesNo:(NSString *)message done:(void (^)(BOOL yes_selected))done
{
    [self confirm:message yes:_T(@"Yes") no:_T(@"No") done:done];
}

+ (void)confirmYesNo:(NSString *)message title:(NSString *)title done:(void (^)(BOOL yes_selected))done
{
    [self confirm:message title:title yes:_T(@"Yes") no:_T(@"No") done:done];
}

//----------------------------------------
#pragma mark - confirm with ViewController

+ (void)confirm:(UIViewController *)vc message:(NSString *)message yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL yes_selected))done
{
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self confirm:vc message:message title:title yes:yes no:no done:done];
}

+ (void)confirm:(UIViewController *)vc message:(NSString *)message title:(NSString *)title yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL yes_selected))done
{
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:yes style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (done) {
                done(YES);
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:no style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (done) {
                done(NO);
            }
        }]];
        [vc presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[CraryMessageBoxAlertView alloc] initWithTitle:title message:message cancelButtonTitle:no otherButtonTitles:@[yes] done:^(NSInteger index) {
            if (done) {
                done(index==1);
            }
        }];
        [alert show];
    }
}

+ (void)confirmOkCancel:(UIViewController *)vc message:(NSString *)message done:(void (^)(BOOL yes_selected))done
{
    [self confirm:vc message:message yes:_T(@"OK") no:_T(@"Cancel") done:done];
}

+ (void)confirmOkCancel:(UIViewController *)vc message:(NSString *)message title:(NSString *)title done:(void (^)(BOOL yes_selected))done
{
    [self confirm:vc message:message title:title yes:_T(@"OK") no:_T(@"Cancel") done:done];
}

+ (void)confirmYesNo:(UIViewController *)vc message:(NSString *)message done:(void (^)(BOOL yes_selected))done
{
    [self confirm:vc message:message yes:_T(@"Yes") no:_T(@"No") done:done];
}

+ (void)confirmYesNo:(UIViewController *)vc message:(NSString *)message title:(NSString *)title done:(void (^)(BOOL yes_selected))done
{
    [self confirm:vc message:message title:title yes:_T(@"Yes") no:_T(@"No") done:done];
}

@end
