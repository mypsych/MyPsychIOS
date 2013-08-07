//
//  NKSafetyPlanStep6ViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyPlanEntry.h"


@interface NKSafetyPlanStep6ViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;

@property (nonatomic, strong) IBOutlet UITextField *line1Field;
@property (nonatomic, strong) IBOutlet UITextField *line2Field;

@property (nonatomic) BOOL isNewPlan;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;

@end
