//
//  ConfigEditViewController.h
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSString *configKey;

@end
