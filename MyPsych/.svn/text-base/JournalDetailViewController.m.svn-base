//
//  JournalDetailViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "JournalDetailViewController.h"
#import "ProfileDataManager.h"
#import "JournalEntry.h"

@interface JournalDetailViewController ()

@property (assign) BOOL hasEditedYet;
@end

@implementation JournalDetailViewController
@synthesize isNewJournalEntry = _isNewJournalEntry;
@synthesize journalEntry = _journalEntry;
@synthesize titleField = _titleField;
@synthesize journalTextView = _journalTextView;
@synthesize hasEditedYet = _hasEditedYet;

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (!self.hasEditedYet && self.isNewJournalEntry) {
        [textView setText:@""];
    }
    self.hasEditedYet = YES;
}

#pragma mark - Other

- (IBAction)doneEditing:(id)sender {
    // Make edits to goal entry
    if (self.titleField.text)
        [self.journalEntry setTitleString:[self.titleField text]];
    [self.journalEntry setJournalString:[self.journalTextView text]];
    if (self.isNewJournalEntry) {
        [self.journalEntry setJournalDate:[NSDate date]];
        [[ProfileDataManager sharedManager] addJournalEntry:self.journalEntry];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelEditing:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleField setDelegate:self];
    if (!self.isNewJournalEntry) {
        [self.titleField setText:self.journalEntry.titleString];
    }
    [self.journalTextView setText:self.journalEntry.journalString];
    
    self.journalTextView.layer.cornerRadius = 6.0f;
    self.journalTextView.layer.masksToBounds = YES;
    [self.titleField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
