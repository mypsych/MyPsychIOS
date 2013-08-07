//
//  JournalDetailViewController.h
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JournalEntry;

@interface JournalDetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (assign) BOOL isNewJournalEntry;
@property (strong) JournalEntry* journalEntry;
@property (strong) IBOutlet UITextField* titleField;
@property (strong) IBOutlet UITextView* journalTextView;

- (IBAction)doneEditing:(id)sender;
- (IBAction)cancelEditing:(id)sender;

@end
