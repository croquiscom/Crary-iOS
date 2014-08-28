#import <Foundation/Foundation.h>

@interface CraryMessageBox : NSObject

+ (void)alert:(NSString *)message;
+ (void)alert:(NSString *)message done:(void (^)())done;
+ (void)alert:(NSString *)message title:(NSString *)title;
+ (void)alert:(NSString *)message title:(NSString *)title done:(void (^)())done;

+ (void)confirm:(NSString *)message yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL result))done;
+ (void)confirm:(NSString *)message title:(NSString *)title yes:(NSString *)yes no:(NSString *)no done:(void (^)(BOOL result))done;
+ (void)confirmOkCancel:(NSString *)message done:(void (^)(BOOL result))done;
+ (void)confirmOkCancel:(NSString *)message title:(NSString *)title done:(void (^)(BOOL result))done;
+ (void)confirmYesNo:(NSString *)message done:(void (^)(BOOL result))done;
+ (void)confirmYesNo:(NSString *)message title:(NSString *)title done:(void (^)(BOOL result))done;

@end
