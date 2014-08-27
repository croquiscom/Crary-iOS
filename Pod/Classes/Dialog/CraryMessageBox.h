#import <Foundation/Foundation.h>

@interface CraryMessageBox : NSObject

+ (void)alert:(NSString *)message;
+ (void)alert:(NSString *)message done:(void (^)())done;
+ (void)alert:(NSString *)message title:(NSString *)title;
+ (void)alert:(NSString *)message title:(NSString *)title done:(void (^)())done;

@end
