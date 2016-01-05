#import <UIKit/UIKit.h>

@interface CraryInputDialog : NSObject

+ (void)selectSingle:(UIView *)view items:(NSArray<NSString *> *)items done:(void(^)(NSInteger buttonIndex))done;
+ (void)selectSingle:(UIViewController *)vc inView:(UIView *)view items:(NSArray<NSString *> *)items done:(void(^)(NSInteger buttonIndex))done;

@end
