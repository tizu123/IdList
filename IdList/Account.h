//
//  Account.h
//  IdList
//
//  Created by パパ on 2012/08/01.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *loginId;
@property (nonatomic, retain) NSString *subId;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *memo;

@end
