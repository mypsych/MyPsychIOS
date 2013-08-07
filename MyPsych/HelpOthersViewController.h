//
//  HelpOthersViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface HelpOthersViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (strong) IBOutlet UIProgressView* progressBar;

@end
