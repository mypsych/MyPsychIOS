//
//  ChallengeTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ChallengeTableViewController.h"
#import "ChallengeObject.h"
#import "ProfileDataManager.h"
#import "ChallengeCell.h"

@interface ChallengeTableViewController ()

@end

@implementation ChallengeTableViewController

- (IBAction)plusButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"pushNewChallenge" sender:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    int count = [[ProfileDataManager sharedManager] challengeObjectCount];
    if (count <= 0) {
        return @"Use the '+' button to add a new challenge";
    } else {
        if (count == 1) {
            return @"Your current challenge";
        } else {
            return [NSString stringWithFormat:@"Your %i current challenges", count];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ProfileDataManager sharedManager] challengeObjectCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"challengeObjectCell";
    ChallengeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ChallengeObject* object = [[ProfileDataManager sharedManager] challengeObjectForIndex:indexPath.row];
    NSString* challengeName = @"";
    int catIndex = [object.challengeCategoryIndex integerValue];
    float currentValue = 0.0f;
    if ([object.challengeTypeIndex integerValue] == kMainWellbeingIndex) {
        challengeName = [NSString stringWithFormat:@"\"%@\" Challenge", kWellbeingEntryIdentifiers[catIndex]];
        currentValue = [[ProfileDataManager sharedManager] averageWellbeingAverageWithIndex:catIndex forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]];
    } else if ([object.challengeTypeIndex integerValue] == kMainLifestlyeIndex) {
        challengeName = [NSString stringWithFormat:@"\"%@\" Challenge", kLifestyleEntryIdentifiers[catIndex]];
        currentValue = [[ProfileDataManager sharedManager] averageLifestyleAverageWithIndex:catIndex forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]];
    } else if ([object.challengeTypeIndex integerValue] == kMainPersonalIndex) {
        challengeName = [NSString stringWithFormat:@"\"%@\" Challenge", [[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:catIndex]];
        currentValue = [[ProfileDataManager sharedManager] averagePersonalAverageWithIndex:catIndex forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]];
    }
    
    [cell.nameLabel setText:challengeName];
    [cell.currentLabel setText:[NSString stringWithFormat:@"%.1f", currentValue]];
    [cell.targetLabel setText:[NSString stringWithFormat:@"%.1f", [object.challengeTargetScore floatValue]]];
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        ChallengeObject* entry = [[ProfileDataManager sharedManager] challengeObjectForIndex:indexPath.row];
        [[ProfileDataManager sharedManager] removeChallengeObject:entry];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Nothing on tap
}

@end
