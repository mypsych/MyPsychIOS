//
//  NKSafetyPlanStep4ViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/26/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyPlanEntry.h"
#import "SHSPhoneLibrary.h"

@interface NKSafetyPlanStep4ViewController : UIViewController

@property (nonatomic, strong) SafetyPlanEntry *safetyPlanDetails;

@property (nonatomic, strong) IBOutlet UITextField *person1NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *person1PhoneField;
@property (nonatomic, strong) IBOutlet UITextField *person2NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *person2PhoneField;
@property (nonatomic, strong) IBOutlet UITextField *person3NameField;
@property (nonatomic, strong) IBOutlet SHSPhoneTextField *person3PhoneField;

@property (nonatomic) BOOL isNewPlan;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
- (IBAction)didSelectEditButton:(UIButton*)sender;

@end
