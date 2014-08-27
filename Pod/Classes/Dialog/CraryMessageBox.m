#import "CraryMessageBox.h"
#import "Crary+Private.h"

@interface UIAlertViewWithDone : UIAlertView <UIAlertViewDelegate>
@property (nonatomic, copy) void (^done)(int index);
@end

@implementation UIAlertViewWithDone
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles done:(void (^)(int index))done
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

+ (void)alert:(NSString *)message
{
    [self alert:message done:nil];
}

+ (void)alert:(NSString *)message done:(void (^)())done
{
    NSString *title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self alert:message title:title done:done];
}

+ (void)alert:(NSString *)message title:(NSString *)title
{
    [self alert:message title:title done:nil];
}

+ (void)alert:(NSString *)message title:(NSString *)title done:(void (^)())done
{
    UIAlertView *alert = [[UIAlertViewWithDone alloc] initWithTitle:title message:message cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:@[] done:^(int index) {
        if (done) {
            done();
        }
    }];
    [alert show];
}

@end
