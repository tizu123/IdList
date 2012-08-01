//
//  DetailViewController.m
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize account;
@synthesize loginIdButton;
@synthesize subIdButton;
@synthesize passwordButton;
@synthesize urlButton;
@synthesize memoTextView;

#pragma mark - Managing the detail item

- (void)configureView
{
    self.title = account.title;
    [self.loginIdButton setTitle:account.loginId forState:UIControlStateNormal];
    [self.subIdButton setTitle:account.subId forState:UIControlStateNormal];
    [self.passwordButton setTitle:account.password forState:UIControlStateNormal];
    [self.urlButton setTitle:account.url forState:UIControlStateNormal];
    self.memoTextView.text = account.memo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setLoginIdButton:nil];
    [self setSubIdButton:nil];
    [self setPasswordButton:nil];
    [self setUrlButton:nil];
    [self setMemoTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
