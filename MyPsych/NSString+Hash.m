//
//  NSString+Hash.m
//  MyPsych
//
//  Created by Foster Lockwood on 3/27/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NSString+Hash.h"
#import <CommonCrypto/CommonDigest.h>

// This code taken from
// http://www.makebetterthings.com/iphone/how-to-get-md5-and-sha1-in-objective-c-ios-sdk/

@implementation NSString (Hash)

- (NSString*)SHA1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
