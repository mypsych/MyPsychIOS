//
//  NKSafetyPlanStep5ViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyPlanEntry.h"
#import "SHSPhoneLibrary.h"

@interface NKSafetyPlanStep5ViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;

@property (nonatomic, strong) IBOutlet UITextField *clinic1NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *clinic1PhoneField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *clinic1EmergencyField;

@property (nonatomic, strong) IBOutlet UITextField *clinic2NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *clinic2PhoneField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *clinic2EmergencyField;

@property (nonatomic, strong) IBOutlet UITextField *urgentCareNameField;
@property (nonatomic, strong) IBOutlet UITextField *urgentCareAddressField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *urgentCareEmergencyField;

@property (nonatomic) BOOL isNewPlan;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;

@end
