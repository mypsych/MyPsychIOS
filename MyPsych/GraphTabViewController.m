//
//  GraphTabViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/13/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "GraphTabViewController.h"
#import "WellbeingGraphViewController.h"
#import "LifestyleGraphViewController.h"
#import "PersonalGraphViewController.h"
#import "LegendTableViewController.h"
#import "AverageTableViewController.h"
#import "ProfileDataManager.h"

@interface GraphTabViewController ()

@end

@implementation GraphTabViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[AverageTableViewController class]]) {
        AverageTableViewController* controller = (AverageTableViewController*)[segue destinationViewController];
        if ([self.selectedViewController isKindOfClass:[WellbeingGraphViewController class]]) {
            [controller setAverageIndex:kMainWellbeingIndex];
        }
        if ([self.selectedViewController isKindOfClass:[LifestyleGraphViewController class]]) {
            [controller setAverageIndex:kMainLifestlyeIndex];
        }
        if ([self.selectedViewController isKindOfClass:[PersonalGraphViewController class]]) {
            [controller setAverageIndex:kMainPersonalIndex];
        }
    }
}

- (IBAction)todayButtonPressed:(id)sender {
    if ([self.selectedViewController isKindOfClass:[WellbeingGraphViewController class]]) {
        WellbeingGraphViewController* controller = (WellbeingGraphViewController*)self.selectedViewController;
        [controller moveToTodaysDate];
    }
    if ([self.selectedViewController isKindOfClass:[LifestyleGraphViewController class]]) {
        LifestyleGraphViewController* controller = (LifestyleGraphViewController*)self.selectedViewController;
        [controller moveToTodaysDate];
    }
}

- (void)legendButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"modalLegendSeque" sender:self];
    if (self.modalViewController) {
        LegendTableViewController* legendController = (LegendTableViewController*)self.modalViewController;
        if ([self.selectedViewController isKindOfClass:[WellbeingGraphViewController class]]) {
            legendController.legendStyle = kLegendStyleWellbeing;
        }
        if ([self.selectedViewController isKindOfClass:[LifestyleGraphViewController class]]) {
            legendController.legendStyle = kLegendStyleLifestyle;
        }
        if ([self.selectedViewController isKindOfClass:[PersonalGraphViewController class]]) {
            legendController.legendStyle = kLegendStylePersonal;
        }
        [legendController.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Title is todays date
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    NSString* title = [formatter stringFromDate:[NSDate date]];
    [self setTitle:title];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
