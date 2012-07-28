//
//  main.m
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    int retVal;
    @autoreleasepool {
#ifdef DEBUG
        @try {
#endif
            retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
#ifdef DEBUG
        }
        @catch (NSException *exception) {
            d([exception callStackSymbols]);
            @throw exception;
        }
#endif
    }
    return retVal;
}
