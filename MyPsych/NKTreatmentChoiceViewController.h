//
//  NKTreatmentChoiceViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKTreatmentWebView.h"

@interface NKTreatmentChoiceViewController : UITableViewController
{
    NSMutableArray *NKSamhsa;
    NSMutableArray *NKOther;
  
    
}
@property(nonatomic,retain)IBOutlet NKTreatmentWebView *myTreatmentWebView;

@end
