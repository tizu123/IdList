//
//  DetailViewController.h
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Account *account;
@property (weak, nonatomic) IBOutlet UIButton *loginIdButton;
@property (weak, nonatomic) IBOutlet UIButton *subIdButton;
@property (weak, nonatomic) IBOutlet UIButton *passwordButton;
@property (weak, nonatomic) IBOutlet UIButton *urlButton;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
