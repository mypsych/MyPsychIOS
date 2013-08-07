//
//  NKSafetyPlanStep3ViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlanStep3ViewController.h"
#import "NKSafetyPlanStep4ViewController.h"
#import "ProfileDataManager.h"
//#define kOFFSET_FOR_KEYBOARD 110.0

@interface NKSafetyPlanStep3ViewController () {
    float changeInOrigin;
    float viewResetHeight;
}

@end

@implementation NKSafetyPlanStep3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isNewPlan = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewResetHeight = 0;
    
    [self.person1PhoneField.formatter setDefaultOutputPattern:@"(###) ###-####"];
    [self.person2PhoneField.formatter setDefaultOutputPattern:@"(###) ###-####"];

    if (!_isNewPlan) {
        [self setEditing:YES];
    }

_person1NameField.text  = _safetyPlanDetails.step3Person1Name;
_person1PhoneField.text = _safetyPlanDetails.step3Person1Phone;
_person2NameField.text  = _safetyPlanDetails.step3Person2Name;
_person2PhoneField.text = _safetyPlanDetails.step3Person2Phone;
_place1Field.text       = _safetyPlanDetails.step3Place1;
_place2Field.text       = _safetyPlanDetails.step3Place2;

_editButton.hidden = _isNewPlan;
[self enableControls:_isNewPlan];

}

- (void)enableControls:(BOOL)enabled {
    NSLog(@"Enabeled:%i",enabled);
    _person1NameField.enabled  = enabled;
    _person1PhoneField.enabled = enabled;
    _person2NameField.enabled  = enabled;
    _person2PhoneField.enabled = enabled;
    _place1Field.enabled       = enabled;
    _place2Field.enabled       = enabled;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self saveSafetyPlanDetails];
    NKSafetyPlanStep4ViewController *step4VC = segue.destinationViewController;
    step4VC.isNewPlan = _isNewPlan;
    step4VC.safetyPlanDetails = _safetyPlanDetails;
    
}

- (void)saveSafetyPlanDetails {
    // save details
    _safetyPlanDetails.step3Person1Name  = _person1NameField.text;
    _safetyPlanDetails.step3Person1Phone = _person1PhoneField.text;
    _safetyPlanDetails.step3Person2Name  = _person2NameField.text;
    _safetyPlanDetails.step3Person2Phone = _person2PhoneField.text;
    _safetyPlanDetails.step3Place1       = _place1Field.text;
    _safetyPlanDetails.step3Place2       = _place2Field.text;
    
    NSLog(@"Safety Plan:%@", [_safetyPlanDetails getDictionaryFromEntry]);

    
    if (!_isNewPlan) {
        [[ProfileDataManager sharedManager] updateSafetyPlanWithEntry:_safetyPlanDetails
                                                            withBlock:^{}];
    }
}

#pragma mark - View controller slider

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



-(void)keyboardWillShow {
    // Animate the current view out of the way
}

-(void)keyboardWillHide {
    //[self setViewMovedUp:NO];
    
    [self resetView];
}


- (void)resetView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = 0;
    rect.size.height -= viewResetHeight ;
    self.view.frame = rect;
    viewResetHeight = 0;
    changeInOrigin = 0;
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y += changeInOrigin;
    rect.size.height -= changeInOrigin ;
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - UI text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    int origin = self.view.frame.origin.y;
    int textFieldPosition = textField.frame.origin.y;
    // calc change in view position
    
    NSLog(@"Text Box Position:%i", textFieldPosition);
    NSLog(@"origin:%i", origin);
    
    changeInOrigin =  90 - textFieldPosition - origin;
    viewResetHeight = viewResetHeight - changeInOrigin;
    
    NSLog(@"Change in Origin:%f", changeInOrigin);
    NSLog(@"Reset height:%f", viewResetHeight);
    
    [self setViewMovedUp:YES];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    return;
}

@end
