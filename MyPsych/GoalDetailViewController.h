//
//  GoalDetailViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@class GoalEntry;

@interface GoalDetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (assign) BOOL isNewGoalEntry;
@property (strong) GoalEntry* goalEntry;
@property (strong) IBOutlet UITextField* titleField;
@property (strong) IBOutlet UITextField* goalTextField;
@property (strong) IBOutlet UIDatePicker* datePicker;
@property (strong) IBOutlet UISwitch* notifySwitch;
@property (strong) IBOutlet UISwitch* addSwitch;

- (IBAction)doneEditing:(id)sender;
- (IBAction)cancelEditing:(id)sender;

@end
