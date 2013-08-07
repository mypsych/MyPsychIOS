//
//  PINViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/18/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PINViewController : UIViewController <UITextFieldDelegate>

@property (strong) IBOutlet UITextField* pinField;
@property (strong) IBOutlet UIBarButtonItem* doneButton;

- (void)doneButtonPressed;

@end
