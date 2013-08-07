//
//  MessageEntryViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "MessageEntryViewController.h"
#import "ProfileDataManager.h"
#import <QuartzCore/QuartzCore.h>

@interface MessageEntryViewController ()

@end

@implementation MessageEntryViewController

- (IBAction)sendButtonPressed:(UIBarButtonItem*)sender {
    if (![self.textEntryView.text isEqual:@""]) {
        [sender setEnabled:NO];
        [[ProfileDataManager sharedManager] sendMessageToDoctor:self.doctorID message:self.textEntryView.text withBlock:^{
            // Sent!
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Please enter a message to send."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.textEntryView.layer.cornerRadius = 6.0f;
    self.textEntryView.layer.masksToBounds = YES;
    
    [self.textEntryView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
