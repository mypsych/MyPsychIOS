//
//  GoalTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "GoalTableViewController.h"
#import "ProfileDataManager.h"
#import "GoalEntry.h"
#import "GoalDetailViewController.h"

@interface GoalTableViewController ()

@end

@implementation GoalTableViewController

- (IBAction)createNewGoal:(id)sender {
    GoalEntry* newEntry = [[GoalEntry alloc] init];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    GoalDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"goalDetailViewController"];
    [controller setGoalEntry:newEntry];
    [controller setIsNewGoalEntry:YES];
    [self presentModalViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[ProfileDataManager sharedManager] goalEntryCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"goalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    GoalEntry* entry = [[ProfileDataManager sharedManager] goalEntryForIndex:indexPath.row];
    cell.textLabel.text = entry.titleString;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [formatter stringForObjectValue:[[NSCalendar currentCalendar] dateFromComponents:entry.dueDateComps]];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        GoalEntry* entry = [[ProfileDataManager sharedManager] goalEntryForIndex:indexPath.row];
        [entry removeNotifications];
        [[ProfileDataManager sharedManager] removeGoalEntry:entry];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    GoalEntry* entry = [[ProfileDataManager sharedManager] goalEntryForIndex:indexPath.row];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    GoalDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"goalDetailViewController"];
    [controller setGoalEntry:entry];
    [controller setIsNewGoalEntry:NO];
    [self presentModalViewController:controller animated:YES];
}

@end
