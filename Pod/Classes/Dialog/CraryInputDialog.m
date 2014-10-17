#import "CraryInputDialog.h"
#import "Crary+Private.h"

@interface UIActionSheetWithDone : UIActionSheet <UIActionSheetDelegate>
@property (nonatomic, copy) void (^done)(NSInteger buttonIndex);
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles done:(void(^)(NSInteger buttonIndex))done;

@end

@implementation UIActionSheetWithDone
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles done:(void(^)(NSInteger buttonIndex))done
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

#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.done) {
        self.done(buttonIndex);
    }
}
@end

@implementation CraryInputDialog

+ (void)selectSingle:(UIView *)view items:(NSArray *)items done:(void (^)(NSInteger))done
{
    UIActionSheetWithDone *actionSheet = [[UIActionSheetWithDone alloc] initWithTitle:nil cancelButtonTitle:_T(@"Cancel") otherButtonTitles:items done:done];
    [actionSheet showInView:view];
}
@end
