//
//  PersonalTitleEditViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/19/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTitleEditViewController : UIViewController

@property (assign) int personalIndex;
@property (strong) IBOutlet UITextField* titleField;
@property (strong) IBOutlet UITextView *infoTextView;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
