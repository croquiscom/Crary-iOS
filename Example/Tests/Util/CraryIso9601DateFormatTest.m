#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryIso9601DateFormat.h"

static NSDate *baseDate()
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:2014];
    [components setMonth:11];
    [components setDay:25];
    [components setHour:10];
    [components setMinute:30];
    [components setSecond:5];
    [components setNanosecond:10000000];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    return [calendar dateFromComponents:components];
}

SpecBegin(CraryIso9601DateFormatSpecs)

it(@"parse", ^{
    NSDate *date = [CraryIso9601DateFormat parse:@"2014-11-25T10:30:05.010Z"];
    expect([date timeIntervalSince1970]).to.equal([baseDate() timeIntervalSince1970]);
});

it(@"format", ^{
    NSString *string = [CraryIso9601DateFormat format:baseDate()];
    expect(string).to.equal(@"2014-11-25T10:30:05.010Z");
});

SpecEnd
