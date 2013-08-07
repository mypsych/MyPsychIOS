//
//  PersonalTitleEditViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/19/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "PersonalTitleEditViewController.h"
#import "ProfileDataManager.h"
#import "FeelingTabViewController.h"

@interface PersonalTitleEditViewController ()

@end

@implementation PersonalTitleEditViewController
@synthesize personalIndex = _personalIndex;
@synthesize titleField = _titleField;
@synthesize infoTextView = _infoTextView;

- (void)viewDidLoad {
    [self.infoTextView setText:kPersonalInfoText];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.titleField becomeFirstResponder];
}

- (IBAction)doneButtonPressed:(id)sender {
    if ([self.titleField.text caseInsensitiveCompare:@""] != NSOrderedSame) {
        // Not empty, save text!
        [[ProfileDataManager sharedManager] setPersonalEntryIndetifier:self.titleField.text
                                                              forIndex:self.personalIndex];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
