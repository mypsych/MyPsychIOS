//
//  MessagesViewController.h
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesViewController : UITableViewController

@property (strong) NSNumber* doctorID;

- (IBAction)composeButtonPressed:(id)sender;

@end
