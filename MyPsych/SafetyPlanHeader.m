//
//  SafetyPlanHeader.m
//  MyPsych
//
//  Created by Ryan Nam on 7/25/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "SafetyPlanHeader.h"

#define SPIdentifierKey @"id"
#define SPOwnerKey      @"owner"
#define SPDateKey       @"plane_date"
#define SPUserIDKey     @"user_id"
#define SPNameKey       @"plan_name"

@implementation SafetyPlanHeader

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        NSLog(@"dict:%@", dict);
        _identifier = [dict objectForKey:SPIdentifierKey];
        _owner      = [dict objectForKey:SPOwnerKey];
        _date       = [dict objectForKey:SPDateKey];
        _userID     = [dict objectForKey:SPUserIDKey];
        _name       = [dict objectForKey:SPNameKey];
    }
    return self;
    
}

@end
