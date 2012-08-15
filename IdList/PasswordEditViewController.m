//
//  PasswordEditViewController.m
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "PasswordEditViewController.h"
#import "CMKeychain.h"

@interface PasswordEditViewController ()

@end

@implementation PasswordEditViewController
@synthesize oldPasswordField;
@synthesize passwordField;
@synthesize passwordVefiryField;

- (IBAction)done:(id)sender {
    NSString *error = nil;
    if (![oldPasswordField.text isEqualToString:[CMKeychain getPasswordForId:@"RootPassword"]]) {
        error = NSLocalizedString(@"AlertMessageOldPasswordUncorrect", @"alert message old password is not correct");
    } else if ([passwordField.text isEqualToString:@""]) {
        error = NSLocalizedString(@"AlertMessageNewPasswordEmpty", @"alert message new password is Empty");
    } else if (![passwordField.text isEqualToString:passwordVefiryField.text]) {
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
        [CMKeychain setPassword:self.passwordField.text forId:@"RootPassword"];
        [self.navigationController popViewControllerAnimated:YES];
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setPasswordVefiryField:nil];
    [self setOldPasswordField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
