//
//  Account.m
//  IdList
//
//  Created by tizu123 on 12/08/10.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "Account.h"
#import "KeychainItemWrapper.h"
#import "Security/Security.h"
#import "NSManagedObjectID+getId.h"

@interface Account()
@property (nonatomic, strong) KeychainItemWrapper *keychainItem;
@end

@implementation Account

@dynamic loginId;
@dynamic memo;
@dynamic spare;
@dynamic title;
@dynamic url;
@dynamic image;

- (NSString *)password
{
    // return @"password"; // TODO: 一時的にパスワードの保存をあきらめる。
    if (!self.keychainItem) {
        self.keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:self.objectID.pid accessGroup:nil];
    }
    return [self.keychainItem objectForKey:(__bridge id)(kSecAttrService)];
    
}

- (void)setPassword:(NSString *)password
{
    // return; // TODO: 一時的にパスワードの保存をあきらめる。
    if (!self.keychainItem) {
        self.keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:self.objectID.pid accessGroup:nil];
    }
    [self.keychainItem setObject:password forKey:(__bridge id)(kSecAttrService)];
}


@end
