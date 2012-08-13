//
//  CMKeychain.m
//  IdList
//
//  Created by tizu123 on 12/08/13.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "CMKeychain.h"
#import "Security/Security.h"

#define SERVICE_NAME @"IdList"

@implementation CMKeychain

+ (void)setPassword:(NSString *)password forId:(NSString *)identifier
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(id)SERVICE_NAME forKey:(__bridge id)kSecAttrService];
    [query setObject:(id)identifier forKey:(__bridge id)kSecAttrAccount];
    
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    
    if (err == noErr) {
        // update
        // TODO: error handler
        [attr setObject:passwordData forKey:(__bridge id)kSecValueData];
        SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attr);
    } else {
        // add
        [attr setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        [attr setObject:(id)SERVICE_NAME forKey:(__bridge id)kSecAttrService];
        [attr setObject:(id)identifier forKey:(__bridge id)kSecAttrAccount];
        [attr setObject:passwordData forKey:(__bridge id)kSecValueData];
        SecItemAdd((__bridge CFDictionaryRef)(attr), NULL);
    }
    
}

+ (NSString *)getPasswordForId:(NSString *)identifier
{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(id)SERVICE_NAME forKey:(__bridge id)kSecAttrService];
    [query setObject:(id)identifier forKey:(__bridge id)kSecAttrAccount];
    [query setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef passwordData = NULL;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&passwordData);
    
    if (err == noErr) {
        return [[NSString alloc] initWithBytes:[(__bridge NSData *)passwordData bytes] length:[(__bridge NSData *)passwordData length] encoding:NSUTF8StringEncoding];
    } else if(err == errSecItemNotFound) {
        return nil;
    } else {
        NSLog(@"SecItemCopyMatching: error(%ld)", err);
    }
    return nil;
}


@end
