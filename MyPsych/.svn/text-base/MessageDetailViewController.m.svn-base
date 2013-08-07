//
//  MessageDetailViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/29/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.textView setText:[self.messageDict objectForKey:@"message"]];
    [self.senderLabel setText:[NSString stringWithFormat:@"From: %@", [self.messageDict objectForKey:@"sender_name"]]];
    [self.timeLabel setText:[NSString stringWithFormat:@"Date: %@", [self.messageDict objectForKey:@"created"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
