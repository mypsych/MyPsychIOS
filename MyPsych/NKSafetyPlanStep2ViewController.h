//
//  NKSafetyPlanStep2ViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyPlanEntry.h"


@interface NKSafetyPlanStep2ViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;

@property (nonatomic, strong) IBOutlet UITextField *line1Field;
@property (nonatomic, strong) IBOutlet UITextField *line2Field;
@property (nonatomic, strong) IBOutlet UITextField *line3Field;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;
@property (nonatomic) BOOL isNewPlan;


@end
