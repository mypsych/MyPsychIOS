//
//  SafetyPlanHeader.h
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafetyPlanHeader : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSData   *date;
@property (nonatomic, strong) NSNumber *userID;


- (id)initWithDictionary:(NSDictionary *)dict;
@end
