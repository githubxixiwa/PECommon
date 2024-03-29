//
//  UIColor+PECommonAdd.m
//  PECommon
//
//  Created by sky on 2020/11/10.
//

#import "UIColor+PECommonAdd.h"

@implementation UIColor (PECommonAdd)
/// hexStr 转 UIColor
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (sky_hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

/// hexStr 转 UIColor 支持暗黑模式
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr darkHexString:(NSString *)darkHexStr {
    UIColor *color = [self colorWithHexString:hexStr];
    if (!darkHexStr.length) {
        return color;
    }
    UIColor *darkColor = [self colorWithHexString:darkHexStr];
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                //浅色模式
                return color;
            } else {
                //深色模式
                return darkColor;
            }
        }];
    }
    return color;;
}

static BOOL sky_hexStrToRGBA(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString * tStr = [str stringByTrimmingCharactersInSet:set];
    str = [tStr uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = sky_hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = sky_hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = sky_hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = sky_hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = sky_hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = sky_hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = sky_hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = sky_hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static inline NSUInteger sky_hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (NSString *)hexString {
    return [self hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(self.alpha * 255.0 + 0.5)];
    }
    return hex;
}
@end
