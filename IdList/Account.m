//
//  Account.m
//  IdList
//
//  Created by tizu123 on 12/08/10.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "Account.h"
#import "CMKeychain.h"
#import "NSManagedObjectID+getId.h"

@interface Account()
//@property (nonatomic, strong) KeychainItemWrapper *keychainItem;
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
    return [CMKeychain getPasswordForId:self.objectID.pid];
}

- (void)setPassword:(NSString *)password
{
    [CMKeychain setPassword:password forId:self.objectID.pid];
}


@end
