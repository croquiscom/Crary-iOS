#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CrarySimpleMarkup.h"

static NSDictionary *_checkAttributes(id self, NSAttributedString *str, NSUInteger index, NSInteger location, NSInteger length, NSInteger count)
{
    NSRange range;
    NSDictionary *attrs = [str attributesAtIndex:index longestEffectiveRange:&range inRange:NSMakeRange(0, str.length)];
    expect(attrs.count).to.equal(count);
    expect(range.location).to.equal(location);
    expect(range.length).to.equal(length);
    return attrs;
}

static void _checkFont(id self, NSDictionary *attrs, NSString *fontName, CGFloat fontSize)
{
    UIFont *font = attrs[NSFontAttributeName];
    expect(font).toNot.beNil;
    expect(font.fontName).to.equal(fontName);
    expect(font.pointSize).to.equal(fontSize);
}

static void _checkColor(id self, NSDictionary *attrs, unsigned int r, unsigned int g, unsigned int b)
{
    UIColor *color = attrs[NSForegroundColorAttributeName];
    expect(color).toNot.beNil;
    const CGFloat* components = CGColorGetComponents(color.CGColor);
    expect(components[0]).to.equal(r/255.0f);
    expect(components[1]).to.equal(g/255.0f);
    expect(components[2]).to.equal(b/255.0f);
}

SpecBegin(CrarySimpleMarkupSpecs)

describe(@"bold", ^{
    it(@"font 1", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [bold] text" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a bold text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 4, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        attrs = _checkAttributes(self, str, 14, 14, 5, 0);
    });

    it(@"font 2", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [bold] text" withFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        expect(str.string).to.equal(@"This is a bold text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 4, 1);
        _checkFont(self, attrs, @"HelveticaNeue-Bold", 12);
        attrs = _checkAttributes(self, str, 14, 14, 5, 0);
    });

    it(@"font nil", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [bold] text" withFont:nil];
        expect(str.string).to.equal(@"This is a bold text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 19, 0);
    });

    it(@"no bold font", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [bold] text" withFont:[UIFont fontWithName:@"Symbol" size:10]];
        expect(str.string).to.equal(@"This is a bold text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 4, 1);
        _checkFont(self, attrs, @"Symbol", 10);
        attrs = _checkAttributes(self, str, 14, 14, 5, 0);
    });

    it(@"system font", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [bold] text" withFont:[UIFont systemFontOfSize:15]];
        expect(str.string).to.equal(@"This is a bold text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 4, 1);
        _checkFont(self, attrs, [UIFont boldSystemFontOfSize:15].fontName, 15);
        attrs = _checkAttributes(self, str, 14, 14, 5, 0);
    });

    it(@"multiple", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"You [can] mark [multiple items] on the [string]" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"You can mark multiple items on the string");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 4, 0);
        attrs = _checkAttributes(self, str, 4, 4, 3, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        attrs = _checkAttributes(self, str, 7, 7, 6, 0);
        attrs = _checkAttributes(self, str, 13, 13, 14, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        attrs = _checkAttributes(self, str, 27, 27, 8, 0);
        attrs = _checkAttributes(self, str, 35, 35, 6, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
    });

    it(@"escape", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a \\[bold\\] text" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a [bold] text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 21, 0);
    });

    it(@"nested", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a [nested [bold] text]" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a nested [bold text]");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 12, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        attrs = _checkAttributes(self, str, 22, 22, 6, 0);
    });
});

describe(@"color", ^{
    it(@"#rgb", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a {#931|color} text" withFont:nil];
        expect(str.string).to.equal(@"This is a color text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 5, 1);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 15, 15, 5, 0);
    });

    it(@"#rrggbb", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a {#ac41ec|color} text" withFont:nil];
        expect(str.string).to.equal(@"This is a color text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 5, 1);
        _checkColor(self, attrs, 0xac, 0x41, 0xec);
        attrs = _checkAttributes(self, str, 15, 15, 5, 0);
    });

    it(@"nested", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a {#931|color} {#3b0|text}" withFont:nil];
        expect(str.string).to.equal(@"This is a color text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 10, 0);
        attrs = _checkAttributes(self, str, 10, 10, 5, 1);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 15, 15, 1, 0);
        attrs = _checkAttributes(self, str, 16, 16, 4, 1);
        _checkColor(self, attrs, 0x33, 0xbb, 0x00);
    });

    it(@"escape", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is a \\{#931|color\\} text" withFont:nil];
        expect(str.string).to.equal(@"This is a {#931|color} text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 27, 0);
    });
});

describe(@"mix", ^{
    it(@"1", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is [a {#931|mixed} text]" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a mixed text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 8, 0);
        attrs = _checkAttributes(self, str, 8, 8, 2, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        attrs = _checkAttributes(self, str, 10, 10, 5, 2);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 15, 15, 5, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
    });

    it(@"2", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is {#931|a [mixed] text}" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a mixed text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 8, 0);
        attrs = _checkAttributes(self, str, 8, 8, 2, 1);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 10, 10, 5, 2);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 15, 15, 5, 1);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
    });

    it(@"3", ^{
        NSAttributedString *str = [CrarySimpleMarkup parse:@"This is {#931|a [mixed} text]" withFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
        expect(str.string).to.equal(@"This is a mixed text");
        NSDictionary *attrs;
        attrs = _checkAttributes(self, str, 0, 0, 8, 0);
        attrs = _checkAttributes(self, str, 8, 8, 2, 1);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 10, 10, 5, 2);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
        _checkColor(self, attrs, 0x99, 0x33, 0x11);
        attrs = _checkAttributes(self, str, 15, 15, 5, 1);
        _checkFont(self, attrs, @"AppleSDGothicNeo-SemiBold", 14);
    });
});

SpecEnd
