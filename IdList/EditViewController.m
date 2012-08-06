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
#import "EditUrlViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editUrl"]) {
        [segue.destinationViewController setDelegate:self];
    }
}

- (void)editUrl:(NSString *) url
{
    self.urlField.text = url;
}

- (void)configureView
{
    if (self.account) {
        self.titleField.text = self.account.title;
        self.loginIdField.text = self.account.loginId;
        self.subIdField.text = self.account.subId;
        self.passwordField.text = self.account.password;
        self.urlField.text = self.account.url;
        self.memoTextView.text = self.account.memo;
    }
}

- (IBAction)done:(id)sender {
    
    NSManagedObjectContext *context;
    if (account) { // 編集
        context = account.managedObjectContext;
    } else { // 新規追加
        context = self.managedObjectContext;
        account = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Account class])  inManagedObjectContext:context];
    }
    account.title = self.titleField.text;
    account.loginId = self.loginIdField.text;
    account.subId = self.subIdField.text;
    account.password = self.passwordField.text;
    account.url = self.urlField.text;
    account.memo = self.memoTextView.text;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
    [self configureView];
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
