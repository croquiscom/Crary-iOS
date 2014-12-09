#import "CrarySimpleMarkup.h"

@implementation CrarySimpleMarkup

+ (void)_applyBold:(NSMutableAttributedString *)str withFont:(UIFont *)font
{
    UIFont *boldFont = [UIFont fontWithDescriptor:[[font fontDescriptor] fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:0];
    if (boldFont==nil) {
        boldFont = font;
    }
    NSAttributedString *original = [str copy];
    __block NSUInteger offset = 0;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\[(.+?)(?<!\\\\)\\]" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    [re enumerateMatchesInString:original.string options:0 range:NSMakeRange(0, original.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSMutableAttributedString *substr = [[original attributedSubstringFromRange:[result rangeAtIndex:1]] mutableCopy];
        if (boldFont!=nil) {
            [substr addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, substr.length)];
        }
        [str replaceCharactersInRange:NSMakeRange(result.range.location-offset, result.range.length) withAttributedString:substr];
        offset += result.range.length - substr.length;
    }];

    [[str mutableString] replaceOccurrencesOfString:@"\\[" withString:@"[" options:0 range:NSMakeRange(0, str.length)];
    [[str mutableString] replaceOccurrencesOfString:@"\\]" withString:@"]" options:0 range:NSMakeRange(0, str.length)];
}

+ (void)_applyColor:(NSMutableAttributedString *)str
{
    NSAttributedString *original = [str copy];
    __block NSUInteger offset = 0;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\{#([0-9a-fA-F]{3,6})\\|(.+?)(?<!\\\\)\\}" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    [re enumerateMatchesInString:original.string options:0 range:NSMakeRange(0, original.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        unsigned int colorValue = 0;
        NSRange colorRange = [result rangeAtIndex:1];
        NSScanner *colorScanner = [NSScanner scannerWithString:[original.string substringWithRange:colorRange]];
        [colorScanner scanHexInt:&colorValue];
        UIColor *color = nil;
        switch (colorRange.length) {
            case 3:
                color = [UIColor colorWithRed:((colorValue>>8)&0xF)/15.0f green:((colorValue>>4)&0xF)/15.0f blue:(colorValue&0xF)/15.0f alpha:1];
                break;
            case 6:
                color = [UIColor colorWithRed:((colorValue>>16)&0xFF)/255.0f green:((colorValue>>8)&0xFF)/255.0f blue:(colorValue&0xFF)/255.0f alpha:1];
                break;
        }
        NSMutableAttributedString *substr = [[original attributedSubstringFromRange:[result rangeAtIndex:2]] mutableCopy];
        if (color!=nil) {
            [substr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, substr.length)];
        }
        [str replaceCharactersInRange:NSMakeRange(result.range.location-offset, result.range.length) withAttributedString:substr];
        offset += result.range.length - substr.length;
    }];

    [[str mutableString] replaceOccurrencesOfString:@"\\{" withString:@"{" options:0 range:NSMakeRange(0, str.length)];
    [[str mutableString] replaceOccurrencesOfString:@"\\}" withString:@"}" options:0 range:NSMakeRange(0, str.length)];
}

+ (NSAttributedString *)parse:(NSString *)str withFont:(UIFont *)font
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:str];
    [result beginEditing];
    [self _applyBold:result withFont:font];
    [self _applyColor:result];
    [result endEditing];
    return result;
}

@end
