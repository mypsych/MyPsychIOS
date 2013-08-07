//
//  ResourceMakeViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/4/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ResourceMakeViewController.h"
#import "ProfileDataManager.h"
#import "ResourceObject.h"

@interface ResourceMakeViewController ()

@end

@implementation ResourceMakeViewController
@synthesize titleField = _titleField;
@synthesize urlField = _urlField;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.titleField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(id)sender {
    // Submit stuff
    // and...
    ResourceObject* object = [[ResourceObject alloc] init];
    object.resourceTitle = self.titleField.text;
    object.resourceURL = self.urlField.text;
    [[ProfileDataManager sharedManager] addResourceObject:object];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.titleField isFirstResponder]) {
        [self.urlField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
