//
//  NKSafetyPlanStep3ViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLibrary.h"
#import "SafetyPlanEntry.h"

@interface NKSafetyPlanStep3ViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;

@property (nonatomic, strong) IBOutlet UITextField *person1NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *person1PhoneField;
@property (nonatomic, strong) IBOutlet UITextField *person2NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *person2PhoneField;
@property (nonatomic, strong) IBOutlet UITextField *place1Field;
@property (nonatomic, strong) IBOutlet UITextField *place2Field;

@property (nonatomic) BOOL isNewPlan;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;


@end
