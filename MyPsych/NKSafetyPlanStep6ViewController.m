//
//  NKSafetyPlanStep6ViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlanStep6ViewController.h"
#import "NKSafetyPlanAffirmationViewController.h"
#import "ProfileDataManager.h"

@interface NKSafetyPlanStep6ViewController (){
    float changeInOrigin;
    float viewResetHeight;
}

@end

@implementation NKSafetyPlanStep6ViewController

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

    if (!_isNewPlan) {
        [self setEditing:YES];
    }
    
    _line1Field.text = _safetyPlanDetails.step6Line1;
    _line2Field.text = _safetyPlanDetails.step6Line2;
    
    _editButton.hidden = _isNewPlan;
    [self enableControls:_isNewPlan];
    
}

- (void)enableControls:(BOOL)enabled {
    NSLog(@"Enabeled:%i",enabled);
    _line1Field.enabled = enabled;
    _line2Field.enabled = enabled;
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

- (void)saveSafetyPlanDetails {
    // save details
    
    _safetyPlanDetails.step6Line1 = _line1Field.text;
    _safetyPlanDetails.step6Line2 = _line2Field.text;
    
    NSLog(@"Safety Plan:%@", [_safetyPlanDetails getDictionaryFromEntry]);

    
    if (!_isNewPlan) {
        [[ProfileDataManager sharedManager] updateSafetyPlanWithEntry:_safetyPlanDetails withBlock:nil];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self saveSafetyPlanDetails];
    
    NKSafetyPlanAffirmationViewController *affirmationVC = segue.destinationViewController;
    affirmationVC.isNewPlan = _isNewPlan;
    affirmationVC.safetyPlanDetails = _safetyPlanDetails;
    
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
