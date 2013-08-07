//
//  SafetyPlanEntry.h
//  MyPsych
//
//  Created by Ryan Nam on 7/24/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SPNameKey;
extern NSString * const SPPhoneKey;
extern NSString * const SPContactKey;

@interface SafetyPlanEntry : NSObject

@property (nonatomic, strong) NSNumber *recordIdentifier;

@property (nonatomic, strong) NSString *step1Line1;
@property (nonatomic, strong) NSString *step1Line2;
@property (nonatomic, strong) NSString *step1Line3;

@property (nonatomic, strong) NSString *step2Line1;
@property (nonatomic, strong) NSString *step2Line2;
@property (nonatomic, strong) NSString *step2Line3;

@property (nonatomic, strong) NSString *step3Person1Name;
@property (nonatomic, strong) NSString *step3Person1Phone;
@property (nonatomic, strong) NSString *step3Person2Name;
@property (nonatomic, strong) NSString *step3Person2Phone;
@property (nonatomic, strong) NSString *step3Place1;
@property (nonatomic, strong) NSString *step3Place2;

@property (nonatomic, strong) NSString *step4Person1;
@property (nonatomic, strong) NSString *step4Person2;
@property (nonatomic, strong) NSString *step4Person3;

@property (nonatomic, strong) NSString *step5Clinic1Name;
@property (nonatomic, strong) NSString *step5Clinic1Phone;
@property (nonatomic, strong) NSString *step5Clinic1Contact;
@property (nonatomic, strong) NSString *step5Clinic2Name;
@property (nonatomic, strong) NSString *step5Clinic2Phone;
@property (nonatomic, strong) NSString *step5Clinic2Contact;
@property (nonatomic, strong) NSString *step5UrgentCareCenterName;
@property (nonatomic, strong) NSString *step5UrgentCareCenterPhone;
@property (nonatomic, strong) NSString *step5UrgentCareCenterContact;

@property (nonatomic, strong) NSString *step6Line1;
@property (nonatomic, strong) NSString *step6Line2;

@property (nonatomic, strong) NSString *planAffirmation;
@property (nonatomic, strong) NSString *planeName;

- (id)initWithDictionary:(NSDictionary *)details forPlanNamed:(NSString *)name;
- (NSDictionary *) getDictionaryFromEntry;
@end
