//
//  RewardsTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/4/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "RewardsTableViewController.h"
#import "ProfileDataManager.h"

#define QUOTE_CELL_MARGIN_HEIGHT 5.0f

@interface RewardsTableViewController ()

@end

@implementation RewardsTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString* quote = [[ProfileDataManager sharedManager] getQuoteForIndex:indexPath.row];
        CGSize textSize = [quote sizeWithFont:[UIFont boldSystemFontOfSize:16]
                            constrainedToSize:CGSizeMake(280, 1000)
                                lineBreakMode:UILineBreakModeWordWrap];
        return textSize.height + (QUOTE_CELL_MARGIN_HEIGHT*2);
    } else {
        return 46.0f;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Unlocked Quotes";
    } else {
        return @"Bonus Resources / Products";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [[ProfileDataManager sharedManager] getQuotesUnlocked];
    } else {
        return 1; // Reward section
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = @"quoteCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSString* quote = [[ProfileDataManager sharedManager] getQuoteForIndex:indexPath.row];
        CGSize textSize = [quote sizeWithFont:[UIFont boldSystemFontOfSize:16]
                            constrainedToSize:CGSizeMake(280, 1000)
                                lineBreakMode:UILineBreakModeWordWrap];
        [cell.textLabel setFrame:CGRectMake(cell.textLabel.frame.origin.x, 
                                            cell.textLabel.frame.origin.y, 
                                            cell.textLabel.frame.size.width, 
                                            textSize.height + (QUOTE_CELL_MARGIN_HEIGHT*2))];
        cell.textLabel.text = quote;
        return cell;
    } else {
        NSString *CellIdentifier = @"rewardCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.textLabel.text = @"Coming soon...";
        return cell;
    }
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
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
