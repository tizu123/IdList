//
//  ConfigEditViewController.m
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "ConfigEditViewController.h"

@interface ConfigEditViewController ()

@end

@implementation ConfigEditViewController
@synthesize textField;
@synthesize configKey;

- (IBAction)done:(id)sender {
    NSUserDefaults *conf = [NSUserDefaults standardUserDefaults];
    // TODO: validate
    [conf setObject:self.textField.text forKey:self.configKey];
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
    self.textField.placeholder = [[NSUserDefaults standardUserDefaults] stringForKey:self.configKey];
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
