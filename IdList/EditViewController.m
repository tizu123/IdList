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
@property (strong, nonatomic) NSData *image;
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
@synthesize imageView;
@synthesize faviconButton;

- (IBAction)getFromWeb:(id)sender {
    // urlからfaviconのurlを生成
    NSString *hostName = [[NSURL URLWithString:self.urlField.text] host];
    NSString *urlString = [NSString stringWithFormat:@"http://www.google.com/s2/favicons?domain=%@", hostName];
    
    // HttpRequestの生成
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    
    // faviconのサイズ調整。全て16x16に統一
    UIImage *beforeImage = [[UIImage alloc] initWithData:data];
    UIImage *afterImage;
    if (beforeImage.size.width < 15.5 || beforeImage.size.width > 16.5) {
        UIGraphicsBeginImageContext(CGSizeMake(16, 16));
        [beforeImage drawInRect:CGRectMake(0, 0, 16, 16)];
        afterImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.image = UIImagePNGRepresentation(afterImage);
        t();
    } else {
        self.image = data;
    }
    [self.faviconButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editUrl"]) {
        [segue.destinationViewController setDelegate:self];
    }
}

- (void)editUrl:(NSString *)url withTitle:(NSString *)title withImageData:(NSData *)imageData
{
    self.urlField.text = url;
    self.titleField.text = title;
    self.imageView.image = [UIImage imageWithData:imageData];
    self.image = imageData;
}

- (void)configureView
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"MaskPassword"]) {
        [self.passwordField setSecureTextEntry:YES];
    }
    if (self.account) {
        self.titleField.text = self.account.title;
        self.loginIdField.text = self.account.loginId;
        self.subIdField.text = self.account.spare;
        self.passwordField.text = self.account.password;
        self.urlField.text = self.account.url;
        self.memoTextView.text = self.account.memo;
        self.imageView.image = [UIImage imageWithData:self.account.image];
        [self.faviconButton setImage:[UIImage imageWithData:self.account.image] forState:UIControlStateNormal];
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
    account.spare = self.subIdField.text;
    account.url = self.urlField.text;
    account.memo = self.memoTextView.text;
    account.image = self.image;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return;
    }
    // TODO:パスワードはkeychainに保存しているため、context saveの後で保存
    account.password = self.passwordField.text;
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
    [self setImageView:nil];
    [self setFaviconButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
