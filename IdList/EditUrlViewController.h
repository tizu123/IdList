//
//  EditUrlViewController.h
//  IdList
//
//  Created by tizu123 on 12/08/06.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditUrlDelegate <NSObject>
- (void)editUrl:(NSString *)url;
@end

@interface EditUrlViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) id <EditUrlDelegate> delegate;
@end