//
//  NKSafetyPlanAffirmationViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyPlanEntry.h"

@interface NKSafetyPlanAffirmationViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;
@property (nonatomic, strong) IBOutlet UITextField *affirmationField;
@property (nonatomic, strong) IBOutlet UITextField *planNameField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightButton;
- (IBAction)saveButtonSelected:(id)sender;

@property (nonatomic) BOOL isNewPlan;


@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;

@end
