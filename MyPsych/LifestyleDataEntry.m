//
//  LifestyleDataEntry.m
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "LifestyleDataEntry.h"

@interface LifestyleDataEntry ()
@property (strong) NSArray* numberList;
@end

@implementation LifestyleDataEntry
@synthesize numberList = _numberList;
@synthesize entryDateComps = _entryDateComps;

- (id)init { // Default, today with all 0s
    self = [super init];
    if (self) {
        NSArray* array = [NSArray arrayWithObjects:
                          [NSNumber numberWithInt:kLifestyleEntryStressDefaultValue],
                          [NSNumber numberWithInt:kLifestyleEntryMoodDefaultValue],
                          [NSNumber numberWithInt:kLifestyleEntryFitnessDefaultValue],
                          [NSNumber numberWithInt:kLifestyleEntryNutritionDefaultValue],
                          [NSNumber numberWithInt:kLifestyleEntrySocialDefaultValue],
                          [NSNumber numberWithInt:kLifestyleEntryRelationshipDefaultValue],nil];
        self.entryDateComps = [ProfileDataManager dateComponentsFromDate:[NSDate date]];
        self.numberList = array;
    }
    return self;
}

- (id)initWithNumberList:(NSArray*)numbers withDate:(NSDateComponents*)dateComps {
    self = [super init];
    if (self) {
        self.entryDateComps = dateComps;
        self.numberList = numbers;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setNumberList:[aDecoder decodeObjectForKey:@"numberList"]];
        [self setEntryDateComps:[aDecoder decodeObjectForKey:@"entryDateComps"]];
        [self setApiEntryID:[aDecoder decodeObjectForKey:@"apiEntryID"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.numberList forKey:@"numberList"];
    [aCoder encodeObject:self.entryDateComps forKey:@"entryDateComps"];
    [aCoder encodeObject:self.apiEntryID forKey:@"apiEntryID"];
}

- (void)setNumber:(NSNumber*)number withIndex:(enum kLifestyleEntryIndex)index {
    NSMutableArray* currentList = [self.numberList mutableCopy];
    [currentList replaceObjectAtIndex:index withObject:number];
    self.numberList = currentList;
}

- (NSNumber*)numberWithIndex:(enum kLifestyleEntryIndex)index {
    if (self.numberList) {
        NSNumber* number = [self.numberList objectAtIndex:index];
        return number;
    }
    return nil;
}

@end
