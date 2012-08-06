//
//  EditUrlViewController.m
//  IdList
//
//  Created by tizu123 on 12/08/06.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "EditUrlViewController.h"

@interface EditUrlViewController ()

@end

@implementation EditUrlViewController
@synthesize webView;

- (IBAction)done:(id)sender {
    [self.delegate editUrl:webView.request.URL.description];
    [self.navigationController popViewControllerAnimated:YES];
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
	NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req]
;}

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
