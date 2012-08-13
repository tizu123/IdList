//
//  LockViewController.m
//  IdList
//
//  Created by パパ on 2012/07/28.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "LockViewController.h"
#import "CMKeychain.h"
//#import "KeychainItemWrapper.h"

@interface LockViewController ()

@end

@implementation LockViewController
@synthesize passwordField;

- (IBAction)unlock:(id)sender {
    NSUserDefaults *conf = [NSUserDefaults standardUserDefaults];
    int count = [conf integerForKey:@"FailureCount"];
    if ([[CMKeychain getPasswordForId:@"RootPassword"] isEqualToString:self.passwordField.text]) {
        // 認証成功。失敗カウントを0に戻してロック解除
        [conf setInteger:0 forKey:@"FailureCount"];
        [self dismissModalViewControllerAnimated:YES];
    } else {
        // 認証失敗。失敗カウントを1増やしてエラーメッセージ出力
        self.passwordField.text = @"";
        count++;
        [conf setInteger:count forKey:@"FailureCount"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failure"
                                                        message:[NSString stringWithFormat:@"Failure Count %d", count]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - view controller
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.passwordField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
