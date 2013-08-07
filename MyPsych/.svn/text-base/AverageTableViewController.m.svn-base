//
//  AverageTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/5/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "AverageTableViewController.h"
#import "ProfileDataManager.h"
#import "AverageCell.h"
#import "FeelingInfoViewController.h"

@interface AverageTableViewController ()

@end

@implementation AverageTableViewController
@synthesize averageIndex = _averageIndex;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[FeelingInfoViewController class]]) {
        FeelingInfoViewController* controller = (FeelingInfoViewController*)[segue destinationViewController];
        if (self.averageIndex == kMainWellbeingIndex) {
            [controller setInfoText:@""];
            [controller setTitle:@"Wellbeing"];
        } else if (self.averageIndex == kMainLifestlyeIndex) {
            [controller setInfoText:@""];
            [controller setTitle:@"Lifestyle"];
        } else if (self.averageIndex == kMainPersonalIndex) {
            [controller setInfoText:@"The personal section is for you to record your own categories."];
            [controller setTitle:@"Personal"];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%i Day Averages", MAX_DAYS_FOR_AVERAGE];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.averageIndex == kMainWellbeingIndex) {
        return WELLBEING_MINIMUM_COUNT;
    } else if (self.averageIndex == kMainLifestlyeIndex) {
        return LIFESTYLE_MINIMUM_COUNT;
    } else if (self.averageIndex == kMainPersonalIndex) {
        return PERSONAL_MINIMUM_COUNT;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"averageCell";
    AverageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSInteger index = indexPath.row;
    
    if (self.averageIndex == kMainWellbeingIndex) {
        [cell.nameLabel setText:kWellbeingEntryIdentifiers[index]];
        [cell.barView setBackgroundColor:[[ProfileDataManager sharedManager] uiColorForIndex:index]];
        [cell.averageLabel setText:[NSString stringWithFormat:@"%.1f", [[ProfileDataManager sharedManager] averageWellbeingAverageWithIndex:index forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]]]];
        if (index == kWellBeingEntryHoursSlept) {
            [cell.barView setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        }
    } else if (self.averageIndex == kMainLifestlyeIndex) {
        [cell.nameLabel setText:kLifestyleEntryIdentifiers[index]];
        [cell.barView setBackgroundColor:[[ProfileDataManager sharedManager] uiColorForIndex:index]];
        [cell.averageLabel setText:[NSString stringWithFormat:@"%.1f", [[ProfileDataManager sharedManager] averageLifestyleAverageWithIndex:index forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]]]];
    } else if (self.averageIndex == kMainPersonalIndex) {
        [cell.nameLabel setText:[[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:index]];
        [cell.barView setBackgroundColor:[[ProfileDataManager sharedManager] uiColorForIndex:index]];
        [cell.averageLabel setText:[NSString stringWithFormat:@"%.1f", [[ProfileDataManager sharedManager] averagePersonalAverageWithIndex:index forDays:MAX_DAYS_FOR_AVERAGE fromDate:[NSDate date]]]];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    FeelingInfoViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"feelingInfoViewController"];
//    if (self.averageIndex == kMainWellbeingIndex) {
//        int average = [[ProfileDataManager sharedManager] averageWellbeingAverageWithIndex:indexPath.row forDays:MAX_DAYS_FOR_AVERAGE  fromDate:[NSDate date]];
//        if (average < 4) {
//            [controller setInfoText:kWellbeingSpecificLowInfoText[indexPath.row]];
//        } else if (average >= 4 && average < 7) {
//            [controller setInfoText:kWellbeingSpecificMidInfoText[indexPath.row]];
//        } else if (average >= 7) {
//            [controller setInfoText:kWellbeingSpecificHighInfoText[indexPath.row]];
//        }
//        [controller setTitle:kWellbeingEntryIdentifiers[indexPath.row]];
//    } else if (self.averageIndex == kMainLifestlyeIndex) {
//        int average = [[ProfileDataManager sharedManager] averageLifestyleAverageWithIndex:indexPath.row forDays:MAX_DAYS_FOR_AVERAGE  fromDate:[NSDate date]];
//        if (average < 4) {
//            [controller setInfoText:kLifestyleSpecificLowInfoText[indexPath.row]];
//        } else if (average >= 4 && average < 7) {
//            [controller setInfoText:kLifestyleSpecificMidInfoText[indexPath.row]];
//        } else if (average >= 7) {
//            [controller setInfoText:kLifestyleSpecificHighInfoText[indexPath.row]];
//        }
//        [controller setTitle:kLifestyleEntryIdentifiers[indexPath.row]];
//    } else if (self.averageIndex == kMainPersonalIndex) {
//        [controller setInfoText:@"The personal section is for you to record your own categories."];
//        [controller setTitle:[[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:indexPath.row]];
//    }
//    [self.navigationController pushViewController:controller animated:YES];
}

@end
