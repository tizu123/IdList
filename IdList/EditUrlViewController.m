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
@synthesize backButton;
@synthesize forwardButton;

- (IBAction)done:(id)sender {
    //title
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    // favicon
    NSString *urlString = [NSString stringWithFormat:@"http://www.google.com/s2/favicons?domain=%@", [webView.request.URL host]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    
    [self.delegate editUrl:webView.request.URL.description withTitle:title withImageData:data];
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
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    
	NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req]
;}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setBackButton:nil];
    [self setForwardButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}


@end
