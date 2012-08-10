//
//  Account.h
//  IdList
//
//  Created by tizu123 on 12/08/10.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * loginId;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * spare;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * image;

@property (nonatomic, strong) NSString *password;

@end
