//
//  AccountDetailsViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/22/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "ProfileDataManager.h"
#import "AppDelegate.h"
#import "TermsOfUseViewController.h"

NSString* const kFirstNameKey = @"savedfirstNameKey";
NSString* const kLastNameKey = @"savedlastNameKey";
NSString* const kEmailKey = @"savedemailKey";

@interface AccountDetailsViewController ()

@property (assign) BOOL hasShownTerms;

- (void)updateUserInfo;
- (void)presentTermsOfUse;

@end

@implementation AccountDetailsViewController

- (IBAction)updateButtonPressed:(id)sender {
    [self becomeFirstResponder];
    
    if ([self.firstNameField.text isEqual:@""] ||
        [self.lastNameField.text isEqual:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Please enter all of your information before you sync it with the MyPsych website."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [sender setEnabled:NO];
    if (![ProfileDataManager sharedManager].clientAccessKey) {
        [[ProfileDataManager sharedManager] loadUserAccessToken:^(NSString *token) {
            [sender setEnabled:YES];
            if (token) {
                [self updateUserInfo];
            } else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"There was an error with MyPsych, please try again."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else {
        [self updateUserInfo];
    }
}

- (void)updateUserInfo {
    [[ProfileDataManager sharedManager] updateUserInfoWithEmail:@"none@email.com"
                                                     withPoints:[[ProfileDataManager sharedManager] currentPsychPoints]
                                                  withFirstName:self.firstNameField.text
                                                   withLastName:self.lastNameField.text
                                                      withBlock:
     ^{
         NSNumber* pin = [[NSUserDefaults standardUserDefaults] objectForKey:kClientPINStoreKey];
         if (pin) {
             [self.clientPINField setText:[NSString stringWithFormat:@"%lli", [pin longLongValue]]];
         } else {
             [self.clientPINField setText:@"(Update info to get PIN)"];
         }
         [[NSUserDefaults standardUserDefaults] setObject:self.firstNameField.text forKey:kFirstNameKey];
         [[NSUserDefaults standardUserDefaults] setObject:self.lastNameField.text forKey:kLastNameKey];
         [[NSUserDefaults standardUserDefaults] setObject:self.emailField.text forKey:kEmailKey];
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"User Info successfully updated."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
         [alert show];
     }];
}

- (void)presentTermsOfUse {
    if (!self.hasShownTerms) {
        self.hasShownTerms = YES;
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TermsOfUseViewController* ctrl = [storyboard instantiateViewControllerWithIdentifier:@"TermsOfUseViewController"];
        [self.navigationController presentViewController:ctrl animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self presentTermsOfUse];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.firstNameField becomeFirstResponder];
    
    self.firstNameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstNameKey];
    self.lastNameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kLastNameKey];
    self.emailField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kEmailKey];
    
    NSNumber* pin = [[NSUserDefaults standardUserDefaults] objectForKey:kClientPINStoreKey];
    
    if (pin) {
        [self.clientPINField setText:[NSString stringWithFormat:@"%lli", [pin longLongValue]]];
    } else {
        [self.clientPINField setText:@"(Update info to get PIN)"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.lastNameField) {
        if (textField.text.length + string.length > 1) {
            textField.text = [textField.text substringToIndex:1];
        } else {
            return YES;
        }
        textField.text = [textField.text uppercaseString];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.firstNameField) {
        [self.lastNameField becomeFirstResponder];
    } else if (textField == self.lastNameField) {
        [self.emailField becomeFirstResponder];
    } else if (textField == self.emailField) {
        [self becomeFirstResponder];
    }
    return NO;
}

@end
