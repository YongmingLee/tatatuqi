//
//  NSString+Util.m
//  tata_oc
//
//  Created by yongming on 2021/9/18.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSString *)ql_urlEncodedStringUsingEncoding:(NSStringEncoding)encoding {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    return result;
//
//    CFStringEncoding cfencoding = CFStringConvertNSStringEncodingToEncoding(encoding);
//
//    return [self ql_urlEncodedUsingCFStringEncoding:cfencoding alreadyPercentEscaped: NO];
}

- (NSString *)ql_urlEncodedUsingCFStringEncoding:(CFStringEncoding)cfencoding alreadyPercentEscaped:(BOOL)percentEscaped {
    //CFStringRef nonAlphaNumValidChars = CFSTR("![ DISCUZ_CODE_1 ]’()*+,-./:;=?@_~");
    CFStringRef nonAlphaNumValidChars = CFSTR("![ ]’()*+,-./:;=?@_~");
    CFStringRef preprocessedString = NULL;
    if(percentEscaped)
    {
        preprocessedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), cfencoding);
    }
    CFStringRef newStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,preprocessedString ? preprocessedString : (__bridge CFStringRef)self,
                                                                 NULL,nonAlphaNumValidChars, cfencoding);
    if(preprocessedString)
    {
        CFRelease(preprocessedString);
    }
    NSString *re = [NSString stringWithFormat:@"%@",(__bridge NSString *)newStr];
    CFRelease(newStr);
    return re;
}


@end
