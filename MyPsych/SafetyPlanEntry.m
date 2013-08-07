//
//  SafetyPlanEntry.m
//  MyPsych
//
//  Created by Ryan Nam on 7/24/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "SafetyPlanEntry.h"

#define step1Line1Key @"step_1_1"
#define step1Line2Key @"step_1_2"
#define step1Line3Key @"step_1_3"

#define step2Line1Key @"step_2_1"
#define step2Line2Key @"step_2_2"
#define step2Line3Key @"step_2_3"

#define step3Person1NameKey  @"step_3_1_name"
#define step3Person1PhoneKey @"step_3_1_phone"
#define step3Person2NameKey  @"step_3_2_name"
#define step3Person2PhoneKey @"step_3_2_phone"
#define step3Place1Key       @"step_3_3_place"
#define step3Place2Key       @"step_3_4_place"

#define step4Person1Key @"step_4_1"
#define step4Person2Key @"step_4_2"
#define step4Person3Key @"step_4_3"

#define step5Clinic1NameKey        @"step_5_1_name"
#define step5Clinic1PhoneKey       @"step_5_1_phone"
#define step5Clinic1ContactKey     @"step_5_1_contact"
#define step5Clinic2NameKey        @"step_5_2_name"
#define step5Clinic2PhoneKey       @"step_5_2_phone"
#define step5Clinic2ContactKey     @"step_5_2_contact"
#define step5UrgentCare3NameKey    @"step_5_3_name"
#define step5UrgentCare3PhoneKey   @"step_5_3_phone"
#define step5UrgentCare3ContactKey @"step_5_3_contact"

#define step6Line1Key @"step_6_1"
#define step6Line2Key @"step_6_2"

#define planAffirmationKey @"safety_plan_affirmation"


NSString* const SPNameKey    = @"name";
NSString* const SPPhoneKey   = @"phone";
NSString* const SPContactKey = @"contact";


@implementation SafetyPlanEntry

- (id) init {
    self = [super init];
    return self;
}

- (id)initWithDictionary:(NSDictionary *)details forPlanNamed:(NSString *)name{
    self = [super init];
    if (self) {
        
        NSLog(@"details:%@",details);
        
        _step1Line1 = [details objectForKey:step1Line1Key];
        _step1Line2 = [details objectForKey:step1Line2Key];
        _step1Line3 = [details objectForKey:step1Line3Key];
        
        _step2Line1 = [details objectForKey:step2Line1Key];
        _step2Line2 = [details objectForKey:step2Line2Key];
        _step2Line3 = [details objectForKey:step2Line3Key];
        
        _step3Person1Name  = [details objectForKey:step3Person1NameKey];
        _step3Person1Phone = [details objectForKey:step3Person1PhoneKey];
        _step3Person2Name  = [details objectForKey:step3Person2NameKey];
        _step3Person2Phone = [details objectForKey:step3Person2PhoneKey];
        _step3Place1 = [details objectForKey:step3Place1Key];
        _step3Place2 = [details objectForKey:step3Place2Key];
        
        _step4Person1 = [details objectForKey:step4Person1Key];
        _step4Person2 = [details objectForKey:step4Person2Key];
        _step4Person3 = [details objectForKey:step4Person3Key];
        
        _step5Clinic1Name    = [details objectForKey:step5Clinic1NameKey];
        _step5Clinic1Phone   = [details objectForKey:step5Clinic1PhoneKey];
        _step5Clinic1Contact = [details objectForKey:step5Clinic1ContactKey];
        _step5Clinic2Name    = [details objectForKey:step5Clinic2NameKey];
        _step5Clinic2Phone   = [details objectForKey:step5Clinic2PhoneKey];
        _step5Clinic2Contact = [details objectForKey:step5Clinic2ContactKey];
        _step5UrgentCareCenterName    = [details objectForKey:step5UrgentCare3NameKey];
        _step5UrgentCareCenterPhone   = [details objectForKey:step5UrgentCare3PhoneKey];
        _step5UrgentCareCenterContact = [details objectForKey:step5UrgentCare3ContactKey];
        _step6Line1 = [details objectForKey:step6Line1Key];
        _step6Line2 = [details objectForKey:step6Line2Key];
        
        _planAffirmation = [details objectForKey:planAffirmationKey];
        _planeName = name;

    }
    return self;
}

- (NSDictionary *) getDictionaryFromEntry {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (_step1Line1 != nil)
        [dict setObject:_step1Line1 forKey:step1Line1Key];
    if (_step1Line2 != nil)
        [dict setObject:_step1Line2 forKey:step1Line2Key];
    if (_step1Line3 != nil)
        [dict setObject:_step1Line3 forKey:step1Line3Key];
    if (_step2Line1 != nil)
        [dict setObject:_step2Line1 forKey:step2Line1Key];
    if (_step2Line2 != nil)
        [dict setObject:_step2Line2 forKey:step2Line2Key];
    if (_step2Line3 != nil)
        [dict setObject:_step2Line3 forKey:step2Line3Key];
    if (_step3Person1Name != nil)
        [dict setObject:_step3Person1Name  forKey:step3Person1NameKey];
    if (_step3Person1Phone != nil)
        [dict setObject:_step3Person1Phone forKey:step3Person1PhoneKey];
    if (_step3Person2Name != nil)
        [dict setObject:_step3Person2Name  forKey:step3Person2NameKey];
    if (_step3Person2Phone != nil)
        [dict setObject:_step3Person2Phone forKey:step3Person2PhoneKey];
    if (_step3Place1 != nil)
        [dict setObject:_step3Place1  forKey:step3Place1Key];
    if (_step3Place2 != nil)
        [dict setObject:_step3Place2  forKey:step3Place2Key];
    if (_step4Person1 != nil)
        [dict setObject:_step4Person1 forKey:step4Person1Key];
    if (_step4Person2 != nil)
        [dict setObject:_step4Person2 forKey:step4Person2Key];
    if (_step4Person3 != nil)
        [dict setObject:_step4Person3 forKey:step4Person3Key];
    if (_step5Clinic1Name != nil)
        [dict setObject:_step5Clinic1Name    forKey:step5Clinic1NameKey];
    if (_step5Clinic1Phone != nil)
        [dict setObject:_step5Clinic1Phone   forKey:step5Clinic1PhoneKey];
    if (_step5Clinic1Contact != nil)
        [dict setObject:_step5Clinic1Contact forKey:step5Clinic1ContactKey];
    if (_step5Clinic2Name != nil)
        [dict setObject:_step5Clinic2Name    forKey:step5Clinic2NameKey];
    if (_step5Clinic2Phone != nil)
        [dict setObject:_step5Clinic2Phone   forKey:step5Clinic2PhoneKey];
    if (_step5Clinic2Contact != nil)
        [dict setObject:_step5Clinic2Contact forKey:step5Clinic2ContactKey];
    if (_step5UrgentCareCenterName != nil)
        [dict setObject:_step5UrgentCareCenterName    forKey:step5UrgentCare3NameKey];
    if (_step5UrgentCareCenterPhone != nil)
        [dict setObject:_step5UrgentCareCenterPhone   forKey:step5UrgentCare3PhoneKey];
    if (_step5UrgentCareCenterContact != nil)
        [dict setObject:_step5UrgentCareCenterContact forKey:step5UrgentCare3ContactKey];
    if (_step6Line1 != nil)
        [dict setObject:_step6Line1 forKey:step6Line1Key];
    if (_step6Line2 != nil)
        [dict setObject:_step6Line2 forKey:step6Line2Key];
    if (_planAffirmation != nil) {
        [dict setObject:_planAffirmation forKey:planAffirmationKey];
    }    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
