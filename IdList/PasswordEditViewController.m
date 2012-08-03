//
//  PasswordEditViewController.m
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "PasswordEditViewController.h"

@interface PasswordEditViewController ()

@end

@implementation PasswordEditViewController
@synthesize oldPasswordField;
@synthesize passwordField;
@synthesize passwordVefiryField;

- (IBAction)done:(id)sender {
    // TODO: localize
    NSUserDefaults *conf = [NSUserDefaults standardUserDefaults];
    NSString *error = nil;
    if (![oldPasswordField.text isEqualToString:[conf stringForKey:@"RootPassword"]]) {
        error = @"Old password is not correct";
    } else if ([passwordField.text isEqualToString:@""]) {
        error = @"New password is Empty";
    } else if (![passwordField.text isEqualToString:passwordVefiryField.text]) {
        error = @"not match";
    }

    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        
        [conf setObject:passwordField.text forKey:@"RootPassword"];
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
