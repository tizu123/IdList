//
//  Account.m
//  IdList
//
//  Created by tizu123 on 12/08/08.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "Account.h"
#import "Security/Security.h"

@implementation Account

@dynamic loginId;
@dynamic memo;
@dynamic subId;
@dynamic title;
@dynamic url;

- (NSString *)password
{
    if (!self.keychainItem) {
        self.keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:self.objectID.description accessGroup:nil];
    }
    return [self.keychainItem objectForKey:(__bridge id)(kSecAttrService)];

}

- (void)setPassword:(NSString *)password
{
    if (!self.keychainItem) {
        self.keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:self.objectID.description accessGroup:nil];
    }
    [self.keychainItem setObject:password forKey:(__bridge id)(kSecAttrService)];
}

 
@end
