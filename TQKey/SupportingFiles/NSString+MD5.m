//
//  NSString+MD5.m
//  TQKey
//
//  Created by naoty on 2014/06/07.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *)MD5Hash
{
    const char *data = [self UTF8String];
    if (self.length == 0) {
        return nil;
    }
    CC_LONG len = self.length;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, len, result);
    NSMutableString *ms = @"".mutableCopy;
    for (int i = 0; i < 16; i++) {
        [ms appendFormat:@"%02X",result[i]];
    }
    return [ms lowercaseString];
}

@end
