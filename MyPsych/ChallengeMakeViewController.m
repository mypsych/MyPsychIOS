//
//  ChallengeMakeViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ChallengeMakeViewController.h"
#import "ProfileDataManager.h"
#import "ChallengeObject.h"

enum kPickerComponents {
    kPickerCategoryComponent,
    kPickerTargetComponent,
};

@interface ChallengeMakeViewController ()

- (float)numberForRow:(NSInteger)row;
@end

@implementation ChallengeMakeViewController
@synthesize typeSelector = _typeSelector;
@synthesize categoryPickerView = _categoryPickerView;

- (float)numberForRow:(NSInteger)row {
    return (float)(row+1)/2.0f;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveButtonPressed:(id)sender {
    // SAVE IT ALLLL!
    ChallengeObject* newObject = [[ChallengeObject alloc] init];
    newObject.challengeDateStarted = [NSDate date];
    newObject.challengeTypeIndex = [NSNumber numberWithInteger:[self.typeSelector selectedSegmentIndex]];
    newObject.challengeCategoryIndex = [NSNumber numberWithInteger:[self.categoryPickerView selectedRowInComponent:kPickerCategoryComponent]];
    newObject.challengeTargetScore = [NSNumber numberWithFloat:[self numberForRow:[self.categoryPickerView selectedRowInComponent:kPickerTargetComponent]]];
    
    if (self.typeSelector.selectedSegmentIndex == kMainWellbeingIndex) {
        newObject.challengeOriginalScore = [NSNumber numberWithFloat:[[ProfileDataManager sharedManager]
                                                                      averageWellbeingAverageWithIndex:[self.categoryPickerView selectedRowInComponent:kPickerCategoryComponent]
                                                                      forDays:MAX_DAYS_FOR_AVERAGE 
                                                                      fromDate:[NSDate date]]];
    }
    
    if (self.typeSelector.selectedSegmentIndex == kMainLifestlyeIndex) {
        newObject.challengeOriginalScore = [NSNumber numberWithFloat:[[ProfileDataManager sharedManager]
                                                                      averageLifestyleAverageWithIndex:[self.categoryPickerView selectedRowInComponent:kPickerCategoryComponent]
                                                                      forDays:MAX_DAYS_FOR_AVERAGE 
                                                                      fromDate:[NSDate date]]];
    }
    
    if (self.typeSelector.selectedSegmentIndex == kMainPersonalIndex) {
        newObject.challengeOriginalScore = [NSNumber numberWithFloat:[[ProfileDataManager sharedManager]
                                                                      averagePersonalAverageWithIndex:[self.categoryPickerView selectedRowInComponent:kPickerCategoryComponent]
                                                                      forDays:MAX_DAYS_FOR_AVERAGE 
                                                                      fromDate:[NSDate date]]];
    }
    
    if (fabsf([newObject.challengeOriginalScore floatValue] - [newObject.challengeTargetScore floatValue]) <= 0.1f) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Your target is too close to your current average" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }

    if ([[ProfileDataManager sharedManager] addChallengeObject:newObject]) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"You can only make one challenge for each category" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)typeSelectorChanged:(id)sender {
    [self.categoryPickerView reloadAllComponents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Picker Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kPickerCategoryComponent) {
        if (self.typeSelector.selectedSegmentIndex == kMainWellbeingIndex) { return WELLBEING_MINIMUM_COUNT; }
        if (self.typeSelector.selectedSegmentIndex == kMainLifestlyeIndex) { return LIFESTYLE_MINIMUM_COUNT; }
        if (self.typeSelector.selectedSegmentIndex == kMainPersonalIndex) { return PERSONAL_MINIMUM_COUNT; }
    } else if (component == kPickerTargetComponent) {
        return 20;
    }
    return 0;
}

#pragma mark - Picker Delegate

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == kPickerCategoryComponent) {
        if (self.typeSelector.selectedSegmentIndex == kMainWellbeingIndex) { return kWellbeingEntryIdentifiers[row]; }
        if (self.typeSelector.selectedSegmentIndex == kMainLifestlyeIndex) { return kLifestyleEntryIdentifiers[row]; }
        if (self.typeSelector.selectedSegmentIndex == kMainPersonalIndex) { return [[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:row]; }
    } else if (component == kPickerTargetComponent) {
        return [NSString stringWithFormat:@"%.1f", [self numberForRow:row]];
    }
    return @"";
}


@end
