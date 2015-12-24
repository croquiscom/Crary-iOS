#import "CraryIso8601DateFormat.h"

@implementation CraryIso8601DateFormat

+ (NSDateFormatter *)_formatter
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    });
    return formatter;
}

+ (NSString *)format:(NSDate *)date
{
    return [[self _formatter] stringFromDate:date];
}

+ (NSDate *)parse:(NSString *)string
{
    return [[self _formatter] dateFromString:string];
}

@end