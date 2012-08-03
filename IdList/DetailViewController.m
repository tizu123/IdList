//
//  DetailViewController.m
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEdit"]) {
        [segue.destinationViewController setAccount:self.account];
        [segue.destinationViewController setManagedObjectContext:nil];
    }
}

- (void)configureView
{
    self.title = account.title;
    [self.loginIdButton setTitle:account.loginId forState:UIControlStateNormal];
    [self.subIdButton setTitle:account.subId forState:UIControlStateNormal];
    [self.passwordButton setTitle:account.password forState:UIControlStateNormal];
    [self.urlButton setTitle:account.url forState:UIControlStateNormal];
    self.memoTextView.text = account.memo;
}

#pragma mark - view delegate

- (void)viewDidAppear:(BOOL)animated
{
    // TODO: 編集画面での更新を即時反映するため、confireViewをdidLoadからdidAppearに移動。正しい？
    [self configureView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
