//
//  WebViewController.h
//  IdList
//
//  Created by パパ on 2012/08/04.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) Account *account;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@end
