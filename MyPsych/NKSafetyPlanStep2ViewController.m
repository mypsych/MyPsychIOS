//
//  NKSafetyPlanStep2ViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlanStep2ViewController.h"
#import "NKSafetyPlanStep3ViewController.h"
#import "ProfileDataManager.h"

#define kOFFSET_FOR_KEYBOARD 110.0


@interface NKSafetyPlanStep2ViewController ()

@end

@implementation NKSafetyPlanStep2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isNewPlan = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_isNewPlan) {
        [self setEditing:YES];
    }
    
    _line1Field.text = _safetyPlanDetails.step2Line1;
    _line2Field.text = _safetyPlanDetails.step2Line2;
    _line3Field.text = _safetyPlanDetails.step2Line3;
    
    _editButton.hidden = _isNewPlan;
    [self enableControls:_isNewPlan];
    
}

- (void)enableControls:(BOOL)enabled {
    NSLog(@"Enabeled:%i",enabled);
    _line1Field.enabled = enabled;
    _line2Field.enabled = enabled;
    _line3Field.enabled = enabled;
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
    NKSafetyPlanStep3ViewController *step3VC = segue.destinationViewController;
    step3VC.isNewPlan = _isNewPlan;
    step3VC.safetyPlanDetails = _safetyPlanDetails;
    
}


- (void)saveSafetyPlanDetails {
    // save details
    
    _safetyPlanDetails.step2Line1 = _line1Field.text;
    _safetyPlanDetails.step2Line2 = _line2Field.text;
    _safetyPlanDetails.step2Line3 = _line3Field.text;
    
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
    if (self.view.frame.origin.y >= 0)
        {
        [self setViewMovedUp:YES];
        }
    else if (self.view.frame.origin.y < 0)
        {
        [self setViewMovedUp:NO];
        }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
        {
        [self setViewMovedUp:YES];
        }
    else if (self.view.frame.origin.y < 0)
        {
        [self setViewMovedUp:NO];
        }
}



//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
        {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        }
    else
        {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - UI text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    return;
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
        {
        [self setViewMovedUp:YES];
        }
    
}

@end
