//
//  GoalEntry.h
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoalEntry : NSObject <NSCoding>

@property (copy) NSString* titleString;
@property (copy) NSString* goalString;
@property (strong) NSDateComponents* dueDateComps;
@property (strong) NSNumber* isNotifying;
@property (strong) UILocalNotification* notification;
@property (strong) NSArray* intervalNotifications;

- (NSString*)stringFromDueDate;

- (void)removeNotifications;

@end
