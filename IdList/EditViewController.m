//
//  EditViewController.m
//  IdList
//
//  Created by パパ on 2012/07/28.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

/**
 * accountがnilなら新規追加、さもなければ既存の編集
 */

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize scrollView;
@synthesize managedObjectContext;
@synthesize account;
@synthesize titleField;
@synthesize loginIdField;
@synthesize subIdField;
@synthesize passwordField;
@synthesize urlField;
@synthesize memoTextView;

- (IBAction)done:(id)sender {
    if (account) { // 編集
    } else { // 新規追加
        account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Account class])  inManagedObjectContext:managedObjectContext];
        account.title = self.titleField.text;
        account.loginId = self.loginIdField.text;
        account.subId = self.subIdField.text;
        account.password = self.passwordField.text;
        account.url = self.urlField.text;
        account.memo = self.memoTextView.text;

        // Save the context.
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    
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
	self.scrollView.contentSize = CGSizeMake(320,960);
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setTitleField:nil];
    [self setLoginIdField:nil];
    [self setSubIdField:nil];
    [self setLoginIdField:nil];
    [self setSubIdField:nil];
    [self setPasswordField:nil];
    [self setUrlField:nil];
    [self setMemoTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
