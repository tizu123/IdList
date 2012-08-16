//
//  EditUrlViewController.h
//  IdList
//
//  Created by tizu123 on 12/08/06.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditUrlDelegate <NSObject>
- (void)editUrl:(NSString *)url withTitle:(NSString *)title withImageData:(NSData *)imageData;
@end

@interface EditUrlViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) id <EditUrlDelegate> delegate;
@end