//
//  FeelingTabViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/13/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "FeelingTabViewController.h"
#import "ViewController.h"
#import "WellbeingViewController.h"
#import "LifestyleViewController.h"
#import "PersonalViewController.h"
#import "ProfileDataManager.h"
#import "FeelingInfoViewController.h"
#import "MySlider.h"

NSString* const kWellbeingInfoText = @"This page is all about your wellbeing. Below you will find an explanation for what each category means.  A value of 10 is good, a value of 0 is bad, but please note that the numbers you assign are all relative. In other words, a '6' for you may mean something completely different than a '6' for another user of this app. We urge you to use the ratings system as it makes sense to you.\n\nYesterday: How did you feel yesterday?\n\nToday: How do you feel today?\n\nTomorrow: How will you feel tomorrow?\n\nEnergy: How much energy do you have today?\n\nWeather: How do you feel about the weather today?\n\nHours Slept: How many hours did you sleep today? If you slept 8.5 hours, round down to 8.";
NSString* const kLifestyleInfoText = @"This page is all about your lifestyle. Below, you will find an explanation of what each category means. Again, please note that the numbers you assign are relative and should make sense to you.\n\nStress: This one is tricky. 0 means you have a lot of stress or do not feel good about your stress. 10 means you do not have a lot of stress or you feel good about your stress.\n\nMood: Are you in a good mood today?\n\nFitness: Are you feeling fit and active today?\n\nNutrition: Are you eating healthy today?\n\nSocial Life: How do you feel about your social life today?\n\nRomantic Life: How do you feel about your romantic life today?";
NSString* const kPersonalInfoText = @"These personal categories are what you make them out to be. You can define your own categories that have not been listed on either of the previous pages. They will be tracked and graphed just like the Wellbeing and Lifestyle categories. Tap on the title under the bar to edit that category.";

@interface FeelingTabViewController ()

@end

@implementation FeelingTabViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[FeelingInfoViewController class]]) {
        FeelingInfoViewController* controller = (FeelingInfoViewController*)[segue destinationViewController];
        if ([sender isKindOfClass:[MySlider class]]) {
            if ([self.selectedViewController isKindOfClass:[WellbeingViewController class]]) {
                int tag = [sender tag];
                [controller setInfoText:kWellbeingBriefInfoText[tag]];
                [controller setTitle:kWellbeingEntryIdentifiers[tag]];
            }
            if ([self.selectedViewController isKindOfClass:[LifestyleViewController class]]) {
                int tag = [sender tag];
                [controller setInfoText:kLifestyleBriefInfoText[tag]];
                [controller setTitle:kLifestyleEntryIdentifiers[tag]];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    self.title = [formatter stringFromDate:[NSDate date]];
    
    self.delegate = self;
}

- (IBAction)doneButtonPressed:(id)sender {
    if ([self.selectedViewController isKindOfClass:[WellbeingViewController class]]) {
        [self setSelectedIndex:1];
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addWellbeingEntry:[ProfileDataManager sharedManager].todaysWellbeingEntry
                                                       withUpdate:hasCompletedWellbeingBars
                                                        withBlock:nil];
        }
        hasCompletedWellbeingBars = YES;
        return;
    }
    if ([self.selectedViewController isKindOfClass:[LifestyleViewController class]]) {
        [self setSelectedIndex:2];
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addLifestyleEntry:[ProfileDataManager sharedManager].todaysLifestyleEntry
                                                       withUpdate:hasCompletedLifestyleBars
                                                        withBlock:nil];
        }
        hasCompletedLifestyleBars = YES;
        return;
    }
    if ([self.selectedViewController isKindOfClass:[PersonalViewController class]]) {
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addPersonalEntry:[ProfileDataManager sharedManager].todaysPersonalEntry
                                                      withUpdate:hasCompletedPersonalBars
                                                       withBlock:nil];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        hasCompletedPersonalBars = YES;
        return;
    }
}

- (IBAction)infoButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"pushInfoController" sender:self];
    FeelingInfoViewController* controller = (FeelingInfoViewController*)self.navigationController.visibleViewController;
    if ([self.selectedViewController isKindOfClass:[WellbeingViewController class]]) {
        [controller.infoTextView setText:kWellbeingInfoText];
        [controller setTitle:@"Wellbeing Info"];
        return;
    }
    if ([self.selectedViewController isKindOfClass:[LifestyleViewController class]]) {
        [controller.infoTextView setText:kLifestyleInfoText];
        [controller setTitle:@"Lifestyle Info"];
        return;
    }
    if ([self.selectedViewController isKindOfClass:[PersonalViewController class]]) {
        [controller.infoTextView setText:kPersonalInfoText];
        [controller setTitle:@"Personal Info"];
        return;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Tab Bar Controller Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([self.selectedViewController isKindOfClass:[WellbeingViewController class]]) {
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addWellbeingEntry:[ProfileDataManager sharedManager].todaysWellbeingEntry
                                                       withUpdate:hasCompletedWellbeingBars
                                                        withBlock:nil];
        }
        hasCompletedWellbeingBars = YES;
        return YES;
    }
    if ([self.selectedViewController isKindOfClass:[LifestyleViewController class]]) {
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addLifestyleEntry:[ProfileDataManager sharedManager].todaysLifestyleEntry
                                                       withUpdate:hasCompletedLifestyleBars
                                                        withBlock:nil];
        }
        hasCompletedLifestyleBars = YES;
        return YES;
    }
    if ([self.selectedViewController isKindOfClass:[PersonalViewController class]]) {
        if ([ProfileDataManager sharedManager].clientAccessKey) {
            [[ProfileDataManager sharedManager] addPersonalEntry:[ProfileDataManager sharedManager].todaysPersonalEntry
                                                      withUpdate:hasCompletedPersonalBars
                                                       withBlock:nil];
        }
        hasCompletedPersonalBars = YES;
        return YES;
    }
    return YES;
}

@end
