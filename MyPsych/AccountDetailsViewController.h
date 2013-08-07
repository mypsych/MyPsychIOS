//
//  AccountDetailsViewController.h
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/22/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountDetailsViewController : UITableViewController <UITextFieldDelegate>

@property (weak) IBOutlet UITextField* firstNameField;
@property (weak) IBOutlet UITextField* lastNameField;
@property (weak) IBOutlet UITextField* emailField;
@property (weak) IBOutlet UITextField* clientPINField;

- (IBAction)updateButtonPressed:(id)sender;

@end
