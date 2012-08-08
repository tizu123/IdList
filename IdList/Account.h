//
//  Account.h
//  IdList
//
//  Created by tizu123 on 12/08/08.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KeychainItemWrapper.h"


@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * loginId;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * subId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * password;

@property (nonatomic, retain) KeychainItemWrapper *keychainItem;

@end
