//
//  PasswordEditViewController.h
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVefiryField;

@end
