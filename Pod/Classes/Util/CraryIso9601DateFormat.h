#import <Foundation/Foundation.h>

@interface CraryIso9601DateFormat : NSObject

+ (NSString *)format:(NSDate *)date;
+ (NSDate *)parse:(NSString *)string;

@end