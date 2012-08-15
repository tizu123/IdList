//
//  MasterViewController.m
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LockViewController.h"
#import "EditViewController.h"
#import "AppDelegate.h"
#import "InitViewController.h"
#import "WebViewController.h"
#import "CMKeychain.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
@synthesize adView;

- (IBAction)segmented:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    if (seg.selectedSegmentIndex == 0) {
        [self performSegueWithIdentifier:@"showConfig" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showEdit" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Account *account = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [segue.destinationViewController setAccount:account];
    } else if ([[segue identifier] isEqualToString:@"showEdit"]) {
        [segue.destinationViewController setAccount:nil];
        [segue.destinationViewController setManagedObjectContext:self.fetchedResultsController.managedObjectContext];
    } else if ([segue.identifier isEqualToString:@"web"]) {
        Account *account = [[self fetchedResultsController] objectAtIndexPath:sender];
        [segue.destinationViewController setAccount:account];
    }
}

#pragma mark - View Controller

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    // 通知センターの登録
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:@"applicationDidBecomeActive" object:nil];
    
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    adView.delegate = self;
}

- (void)viewDidUnload
{
    [self setAdView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - NotificationCenter selector

/**
 * アプリの起動時、復帰時の処理を記述する関数。
 * AppDelegateのdidBecomeActiveからの通知を受けて実行する。
 * 上記関数の中で処理を行えばいいようなものだが、Lock画面の表示等は
 * viewControllerからでないと実施できないためここで実施する。
 *
 * - Root Passwordが設定されていない場合は、パスワード設定画面へ遷移する
 * - SecondsToLockより時間が経過している場合にロック画面を表示する
 */
- (void)applicationDidBecomeActive {
    if (![CMKeychain getPasswordForId:@"RootPassword"]) {
        InitViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"InitViewController"];
        [self presentModalViewController:ivc animated:NO];
        return;
    }

    int sec = [[NSUserDefaults standardUserDefaults] integerForKey:@"SecondsToLock"];
    NSDate *limit = [NSDate dateWithTimeIntervalSinceNow:-sec];
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    if ([app.lastDidEnterBackground earlierDate:limit] == app.lastDidEnterBackground) {
        LockViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocklViewController"];
        [self presentModalViewController:lvc animated:NO];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

-(void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UseSafari"]) {
        Account *account = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:account.url]];
    } else {
        [self performSegueWithIdentifier:@"web" sender:indexPath];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Account *account = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = account.title;
    cell.imageView.image = [UIImage imageWithData:account.image];
}

#pragma mark - iAd delegate 

//iAd取得成功
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    adView.hidden = NO;
}

//iAd取得失敗
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    adView.hidden = YES;
}

@end
