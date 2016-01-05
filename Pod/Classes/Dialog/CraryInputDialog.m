#import "CraryInputDialog.h"
#import "Crary+Private.h"

@interface CraryInputDialogActionSheet : UIActionSheet <UIActionSheetDelegate>
@property (nonatomic, copy) void (^done)(NSInteger buttonIndex);
@end

@implementation CraryInputDialogActionSheet
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles done:(void(^)(NSInteger buttonIndex))done
{
    self = [super initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        for (NSString *title in otherButtonTitles) {
            [self addButtonWithTitle:title];
        }
        
        [self addButtonWithTitle:cancelButtonTitle];
        self.cancelButtonIndex = otherButtonTitles.count;
        self.delegate = self;
        self.done = done;
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.done) {
        self.done(buttonIndex);
    }
}
@end

@implementation CraryInputDialog

+ (void)selectSingle:(UIView *)view items:(NSArray<NSString *> *)items done:(void (^)(NSInteger))done
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self selectSingle:vc inView:view items:items done:done];
}

+ (void)selectSingle:(UIViewController *)vc inView:(UIView *)view items:(NSArray<NSString *> *)items done:(void(^)(NSInteger buttonIndex))done {
    if ([UIAlertController class]) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSUInteger i = 0 ; i < items.count ; i++ ) {
            NSString *title = items[i];
            [actionSheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (done) {
                    done(i);
                }
            }]];
        }
        [actionSheet addAction:[UIAlertAction actionWithTitle:_T(@"Cancel") style:UIAlertActionStyleCancel handler:nil]];
        [actionSheet popoverPresentationController].sourceRect = view.bounds;
        [actionSheet popoverPresentationController].sourceView = view;
        [vc presentViewController:actionSheet animated:YES completion:nil];
    } else {
        CraryInputDialogActionSheet *actionSheet = [[CraryInputDialogActionSheet alloc] initWithTitle:nil cancelButtonTitle:_T(@"Cancel") otherButtonTitles:items done:done];
        [actionSheet showFromRect:view.bounds inView:view animated:YES];
    }
}

@end
