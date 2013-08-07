//
//  LifestyleDataEntry.h
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileDataManager.h"

@interface LifestyleDataEntry : NSObject <NSCoding>

@property (strong) NSDateComponents* entryDateComps;
@property (strong) NSNumber* apiEntryID;

- (id)initWithNumberList:(NSArray*)numbers withDate:(NSDateComponents*)dateComps;

- (void)setNumber:(NSNumber*)number withIndex:(enum kLifestyleEntryIndex)index;
- (NSNumber*)numberWithIndex:(enum kLifestyleEntryIndex)index;

@end
