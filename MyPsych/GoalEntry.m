//
//  GoalEntry.m
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "GoalEntry.h"
#import "ProfileDataManager.h"

@implementation GoalEntry
@synthesize titleString = _titleString;
@synthesize goalString = _goalString;
@synthesize dueDateComps = _dueDateComps;
@synthesize isNotifying = _isNotifying;
@synthesize notification = _notification;

- (id)init {
    self = [super init];
    if (self) {
        self.titleString = @"Goal title";
        self.goalString = @"Describe your goal";
        self.dueDateComps = [ProfileDataManager dateComponentsFromDate:[NSDate date]];
        self.isNotifying = [NSNumber numberWithBool:NO];
        self.notification = nil;
        self.intervalNotifications = nil;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setTitleString:[aDecoder decodeObjectForKey:@"titleString"]];
        [self setGoalString:[aDecoder decodeObjectForKey:@"goalString"]];
        [self setDueDateComps:[aDecoder decodeObjectForKey:@"dueDateComps"]];
        [self setIsNotifying:[aDecoder decodeObjectForKey:@"isNotifying"]];
        [self setNotification:[aDecoder decodeObjectForKey:@"notification"]];
        [self setIntervalNotifications:[aDecoder decodeObjectForKey:@"intervalNotifications"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
    [aCoder encodeObject:self.goalString forKey:@"goalString"];
    [aCoder encodeObject:self.dueDateComps forKey:@"dueDateComps"];
    [aCoder encodeObject:self.isNotifying forKey:@"isNotifying"];
    [aCoder encodeObject:self.notification forKey:@"notification"];
    [aCoder encodeObject:self.intervalNotifications forKey:@"intervalNotifications"];
}

- (NSString*)stringFromDueDate {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    return [formatter stringFromDate:[[NSCalendar currentCalendar] dateFromComponents:self.dueDateComps]];
}

- (void)removeNotifications {
    if (self.notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
        self.notification = nil;
    }
    if (self.intervalNotifications) {
        for (UILocalNotification* noti in self.intervalNotifications) {
            [[UIApplication sharedApplication] cancelLocalNotification:noti];
        }
        self.intervalNotifications = nil;
    }
}

@end
