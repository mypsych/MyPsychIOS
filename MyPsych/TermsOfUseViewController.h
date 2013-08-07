//
//  TermsOfUseViewController.h
//  MyPsych
//
//  Created by Foster Lockwood on 4/8/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsOfUseViewController : UIViewController

@property (weak) IBOutlet UITextView* textView;

- (IBAction)acceptButtonPressed:(UIBarButtonItem*)sender;

@end
