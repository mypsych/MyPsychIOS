//
//  NKLiveChatChoiceViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKTreatmentWebView.h"

@interface NKLiveChatChoiceViewController : UITableViewController

{ 
    NSMutableArray *NKSupport;
    NSMutableArray *NKSubtitle;
    NSMutableArray *NKImages;
}

@property(nonatomic,retain)IBOutlet NKTreatmentWebView *myLiveChatWebView;
@end
