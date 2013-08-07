//
//  NKSafetyPlanStep1ViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlanStep1ViewController.h"
#import "SafetyPlanEntry.h"
#import "NKSafetyPlanStep2ViewController.h"
#import "ProfileDataManager.h"

#define kOFFSET_FOR_KEYBOARD 90.0

@interface NKSafetyPlanStep1ViewController () {
}


@end

@implementation NKSafetyPlanStep1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isNewPlan = YES;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _isNewPlan = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _isNewPlan = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSLog(@"Hidden:%i", _isNewPlan);

    if (!_isNewPlan) {
        //
        _safetyPlanDetails.recordIdentifier = _recordIdentifier;
        _line1Field.text = _safetyPlanDetails.step1Line1;
        _line2Field.text = _safetyPlanDetails.step1Line2;
        _line3Field.text = _safetyPlanDetails.step1Line3;
        
        NSLog(@"Properties:%@, %@, %@", _line1Field.text, _line2Field.text, _line3Field.text);
    }
_myEditButton.hidden = _isNewPlan;
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
        [_myEditButton setTitle:@"Save" forState:UIControlStateNormal];
        [self enableControls:YES];
    } else {
        [_myEditButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self saveSafetyPlanDetails];

        [self enableControls:NO];
    }
}

- (IBAction)didSelectCancelButton:(UIBarButtonItem*)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
        
        
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self saveSafetyPlanDetails];
    NKSafetyPlanStep2ViewController *step2VC = segue.destinationViewController;
    step2VC.isNewPlan         = _isNewPlan;
    step2VC.safetyPlanDetails = _safetyPlanDetails;
    
}

- (void)saveSafetyPlanDetails {
    // Create new safety plan if one does not already exhist
    
    if (_safetyPlanDetails == nil) {
        _safetyPlanDetails = [[SafetyPlanEntry alloc] init];
    }
    
    _safetyPlanDetails.step1Line1 = _line1Field.text;
    _safetyPlanDetails.step1Line2 = _line2Field.text;
    _safetyPlanDetails.step1Line3 = _line3Field.text;
    
    NSLog(@"Safety Plan:%@", [_safetyPlanDetails getDictionaryFromEntry]);
    
    if (!_isNewPlan) {
        [[ProfileDataManager sharedManager] updateSafetyPlanWithEntry:_safetyPlanDetails
                                                            withBlock:^{}];
    }
    
}


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
