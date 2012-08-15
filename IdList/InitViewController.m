//
//  InitViewController.m
//  IdList
//
//  Created by パパ on 2012/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "InitViewController.h"
#import "CMKeychain.h"
//#import "KeychainItemWrapper.h"

@interface InitViewController ()

@end

@implementation InitViewController
@synthesize passwordField;
@synthesize passwordVerifyField;

- (IBAction)init:(id)sender {
    // TODO: PasswordEditViewと冗長な処理になっている。このくらいならいいかと思う。
    NSUserDefaults *conf = [NSUserDefaults standardUserDefaults];
    NSString *error = nil;
    if ([passwordField.text isEqualToString:@""]) {
        error = NSLocalizedString(@"AlertMessageNewPasswordEmpty", @"alert message new password is Empty");
    } else if (![passwordField.text isEqualToString:passwordVerifyField.text]) {
        error = NSLocalizedString(@"AlertMessageNewPasswordNotMatch", @"alert message password is not match");
    }
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        // 初期化
        [CMKeychain setPassword:self.passwordField.text forId:@"RootPassword"];
        [conf setInteger:0 forKey:@"SecondsToLock"];
        [conf setBool:NO forKey:@"UseSafari"];
        [conf setBool:YES forKey:@"MaskPassword"];
        [self dismissModalViewControllerAnimated:YES];
    }
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
    [self.passwordField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setPasswordVerifyField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
