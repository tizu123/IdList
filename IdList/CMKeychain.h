//
//  CMKeychain.h
//  IdList
//
//  Created by tizu123 on 12/08/13.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMKeychain : NSObject

+ (void)setPassword:(NSString *)password forId:(NSString *)identifier;
+ (NSString *)getPasswordForId:(NSString *)identifier;

@end
