//
//  ConfigViewController.m
//  IdList
//
//  Created by tizu123 on 12/08/03.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "ConfigViewController.h"
#import "ConfigEditViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController
@synthesize useSafari;
@synthesize maskPassword;

- (IBAction)useSafari:(id)sender {
   UISwitch *sw = (UISwitch *)sender;    
   [[NSUserDefaults standardUserDefaults] setBool:sw.isOn forKey:@"UseSafari"];
}

- (IBAction)maskPassword:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    [[NSUserDefaults standardUserDefaults] setBool:sw.isOn forKey:@"MaskPassword"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"configEdit"]) {
        [segue.destinationViewController setConfigKey:sender];
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *conf = [NSUserDefaults standardUserDefaults];
    self.useSafari.on = [conf boolForKey:@"UseSafari"];
    self.maskPassword.on = [conf boolForKey:@"MaskPassword"];
}

- (void)viewDidUnload
{
    [self setUseSafari:nil];
    [self setMaskPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1) { // SecondsToLock
        cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"SecondsToLock"] ;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            [self performSegueWithIdentifier:@"configEdit" sender:@"SecondsToLock"];
            break;
        default:
            break;
    }
}

@end
