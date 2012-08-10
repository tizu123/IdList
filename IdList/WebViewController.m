//
//  WebViewController.m
//  IdList
//
//  Created by パパ on 2012/08/04.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize account;
@synthesize webView;

- (IBAction)paste:(id)sender {
    NSString *jsString;
    NSString *jsFormat = @"document.activeElement.value='%@'";
    switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
        case 0:
            jsString = [NSString stringWithFormat:jsFormat, account.loginId];
            break;
        case 1:
            jsString = [NSString stringWithFormat:jsFormat, account.spare];
            break;
        case 2:
            jsString = [NSString stringWithFormat:jsFormat, account.password];
            break;
        default:
            break;
    }
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //[webView stringByEvaluatingJavaScriptFromString:@"$e=document.activeElement;if($e.type=='text'||$e.type=='password')$e.value='Hello World'"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:account.url];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
