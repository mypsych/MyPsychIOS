//
//  LegendTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/17/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "LegendTableViewController.h"
#import "ProfileDataManager.h"

@interface LegendTableViewController ()

@end

@implementation LegendTableViewController
@synthesize legendStyle = _legendStyle;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        switch (self.legendStyle) {
            case kLegendStyleWellbeing:
                return WELLBEING_MINIMUM_COUNT;
                break;
            case kLegendStyleLifestyle:
                return LIFESTYLE_MINIMUM_COUNT;
                break;
            case kLegendStylePersonal:
                return PERSONAL_MINIMUM_COUNT;
                break;
            default:
                return 0;
                break;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"legendCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        UIView* lineView = (UIView*)[cell viewWithTag:1];
        UILabel* labelView = (UILabel*)[cell viewWithTag:2];
        [lineView setBackgroundColor:[[ProfileDataManager sharedManager] uiColorForIndex:indexPath.row]];
        if (self.legendStyle == kLegendStyleWellbeing) {
            if (indexPath.row == kWellBeingEntryHoursSlept) {
                lineView.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }
        }
        
        NSString* legendText = @"";
        switch (self.legendStyle) {
            case kLegendStyleWellbeing:
                legendText = [NSString stringWithFormat:@"%@ plot", kWellbeingEntryIdentifiers[indexPath.row]];
                break;
            case kLegendStyleLifestyle:
                legendText = [NSString stringWithFormat:@"%@ plot", kLifestyleEntryIdentifiers[indexPath.row]];
                break;
            case kLegendStylePersonal:
                legendText = [NSString stringWithFormat:@"%@ plot", [[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:indexPath.row]];
                break;
            default:
                break;
        }
        [labelView setText:legendText];
        
        BOOL isHidden = NO;
        switch (self.legendStyle) {
            case kLegendStyleWellbeing:
                isHidden = [[ProfileDataManager sharedManager] wellBeingGraphHiddenAtIndex:indexPath.row];
                break;
            case kLegendStyleLifestyle:
                isHidden = [[ProfileDataManager sharedManager] lifestyleGraphHiddenAtIndex:indexPath.row];
                break;
            case kLegendStylePersonal:
                isHidden = [[ProfileDataManager sharedManager] personalGraphHiddenAtIndex:indexPath.row];
                break;
            default:
                break;
        }
        
        if (isHidden) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        return cell;
    } else {
        static NSString *CellIdentifier = @"doneCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        return cell;
    }    
}

#pragma mark - Table view delegate

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Graph Legend";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (self.legendStyle) {
            case kLegendStyleWellbeing: {
                BOOL isHidden = [[ProfileDataManager sharedManager] wellBeingGraphHiddenAtIndex:indexPath.row];
                [[ProfileDataManager sharedManager] setWellbeingGraphHidden:!isHidden withIndex:indexPath.row];
                break;
            }
            case kLegendStyleLifestyle: {
                BOOL isHidden = [[ProfileDataManager sharedManager] lifestyleGraphHiddenAtIndex:indexPath.row];
                [[ProfileDataManager sharedManager] setLifestyleGraphHidden:!isHidden withIndex:indexPath.row];
                break;
            }
            case kLegendStylePersonal: {
                BOOL isHidden = [[ProfileDataManager sharedManager] personalGraphHiddenAtIndex:indexPath.row];
                [[ProfileDataManager sharedManager] setPersonalGraphHidden:!isHidden withIndex:indexPath.row];
                break;
            }
            default:
                break;
        }
        [tableView reloadData];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
