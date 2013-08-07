//
//  NKSafetyPlanAffirmationViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlanAffirmationViewController.h"
#import "ProfileDataManager.h"

@interface NKSafetyPlanAffirmationViewController ()

@end

@implementation NKSafetyPlanAffirmationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isNewPlan = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _affirmationField.text = _safetyPlanDetails.planAffirmation;
    _planNameField.text    = _safetyPlanDetails.planeName;
    _editButton.hidden = _isNewPlan;
    [self enableControls:_isNewPlan];
    
}

- (void)enableControls:(BOOL)enabled {
    NSLog(@"Enabeled:%i",enabled);
    _affirmationField.enabled = enabled;
    _planNameField.enabled    = enabled;
    
    if (enabled) {
        _rightButton.title = @"Save";
    } else {
        _rightButton.title = @"Done";
    }
}

- (void)didSelectEditButton:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
        
        [_editButton setTitle:@"Save" forState:UIControlStateNormal];
        [self enableControls:YES];
    } else {
        [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self saveSafetyPlanDetails];
        [self enableControls:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonSelected:(id)sender {

    
    if ([_planNameField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Plan Name cannot blank" message:@"Please enter a plan name" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self saveSafetyPlanDetails];
    }
}


- (void)saveSafetyPlanDetails {
    // save details
    
    _safetyPlanDetails.planAffirmation = _affirmationField.text;
    _safetyPlanDetails.planeName       = _planNameField.text;
    NSLog(@"Safety Plan Name:%@", _safetyPlanDetails.planeName);
    NSLog(@"Safety Plan:%@", [_safetyPlanDetails getDictionaryFromEntry]);

    
    if (_isNewPlan) {
        [[ProfileDataManager sharedManager] addSafetyPlanEntry:_safetyPlanDetails withBlock:^{
            [self dismissModalViewControllerAnimated:YES];
        }];
        
    } else {
        [[ProfileDataManager sharedManager] updateSafetyPlanWithEntry:_safetyPlanDetails withBlock:^{
            [self dismissModalViewControllerAnimated:YES];
}];

    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
@end
