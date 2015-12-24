#import <Foundation/Foundation.h>

@interface CraryIso8601DateFormat : NSObject

+ (NSString *)format:(NSDate *)date;
+ (NSDate *)parse:(NSString *)string;

@end