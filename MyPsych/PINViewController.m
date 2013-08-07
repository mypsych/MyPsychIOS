//
//  PINViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/18/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "PINViewController.h"
#import "ProfileDataManager.h"

@interface PINViewController ()

@end

@implementation PINViewController
@synthesize pinField = _pinField;
@synthesize doneButton = _doneButton;

#pragma mark - Text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.navigationItem setRightBarButtonItem:self.doneButton animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

#pragma mark - VC stuff

- (void)doneButtonPressed {
    [self.pinField resignFirstResponder];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.pinField.text forKey:kSecurityPINStoreKey];
    [defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pinField setDelegate:self];
    [self.navigationItem setRightBarButtonItem:nil animated:NO];
    [self.doneButton setAction:@selector(doneButtonPressed)];
    [self.doneButton setTarget:self];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* savedPIN = [defaults stringForKey:kSecurityPINStoreKey];
    [self.pinField setText:savedPIN];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
