//
//  GoalDetailViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "GoalDetailViewController.h"
#import "ProfileDataManager.h"
#import "GoalEntry.h"

enum kGoalButtonIndex {
    kGoalButtonNone,
    kGoalButtonWeekly,
    kGoalButtonDaily,
};

@interface GoalDetailViewController ()

@end

@implementation GoalDetailViewController
@synthesize isNewGoalEntry = _isNewGoalEntry;
@synthesize goalEntry = _goalEntry;
@synthesize titleField = _titleField;
@synthesize goalTextField = _goalTextField;
@synthesize datePicker = _datePicker;
@synthesize notifySwitch = _notifySwitch;
@synthesize addSwitch = _addSwitch;

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Other

- (IBAction)doneEditing:(id)sender {
    // Make edits to goal entry
    [self.goalEntry setTitleString:[self.titleField text]];
    [self.goalEntry setGoalString:[self.goalTextField text]];
    [self.goalEntry setDueDateComps:[ProfileDataManager dateComponentsFromDate:[self.datePicker date]]];
    [self.goalEntry setIsNotifying:[NSNumber numberWithBool:[self.notifySwitch isOn]]];
    [self.goalEntry removeNotifications];
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setYear:self.goalEntry.dueDateComps.year];
    [comps setMonth:self.goalEntry.dueDateComps.month];
    [comps setDay:self.goalEntry.dueDateComps.day];
    [comps setHour:5];
    NSDate* goalDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    if (self.isNewGoalEntry) {
        [[ProfileDataManager sharedManager] addGoalEntry:self.goalEntry];
        if ([self.addSwitch isOn]) {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            event.title     = self.goalEntry.titleString;
            event.notes     = self.goalEntry.goalString;
            event.allDay    = YES;
            event.startDate = goalDate;
            event.endDate   = goalDate;
            [event setCalendar:[eventStore defaultCalendarForNewEvents]];
            NSError *err = nil;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        }
    }
    if ([self.notifySwitch isOn]) {
        // Subscribe
        [self.goalEntry setIsNotifying:[NSNumber numberWithBool:YES]];
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"How often would you like to be reminded of this goal?"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Never", @"Weekly", @"Daily", nil];
        [sheet showInView:self.view];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelEditing:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleField setDelegate:self];
    if (!self.isNewGoalEntry)  {
        [self.titleField setText:self.goalEntry.titleString];
        [self.goalTextField setText:self.goalEntry.goalString];
    }
    [self.goalTextField setDelegate:self];
    [self.datePicker setDate:[[NSCalendar currentCalendar] dateFromComponents:self.goalEntry.dueDateComps]];
    [self.notifySwitch setOn:[self.goalEntry.isNotifying boolValue]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setYear:self.goalEntry.dueDateComps.year];
    [comps setMonth:self.goalEntry.dueDateComps.month];
    [comps setDay:self.goalEntry.dueDateComps.day];
    [comps setHour:5];
    NSDate* goalDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    if (buttonIndex == kGoalButtonWeekly) {
        // Weekly notifications
        NSTimeInterval goalTime = [goalDate timeIntervalSince1970];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        NSMutableArray* array = [NSMutableArray array];
        while (goalTime > nowTime) {
            UILocalNotification* noti = [[UILocalNotification alloc] init];
            [noti setFireDate:[NSDate dateWithTimeIntervalSince1970:nowTime]];
            [noti setTimeZone:[NSTimeZone defaultTimeZone]];
            [noti setAlertBody:self.goalEntry.titleString];
            [[UIApplication sharedApplication] scheduleLocalNotification:noti];
            [array addObject:noti];
            nowTime += (kOneDayInSeconds*7);
        }
        [self.goalEntry setIntervalNotifications:array];
    } else if (buttonIndex == kGoalButtonDaily) {
        // Daily notifications
        NSTimeInterval goalTime = [goalDate timeIntervalSince1970];
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        NSMutableArray* array = [NSMutableArray array];
        while (goalTime > nowTime) {
            UILocalNotification* noti = [[UILocalNotification alloc] init];
            [noti setFireDate:[NSDate dateWithTimeIntervalSince1970:nowTime]];
            [noti setTimeZone:[NSTimeZone defaultTimeZone]];
            [noti setAlertBody:self.goalEntry.titleString];
            [[UIApplication sharedApplication] scheduleLocalNotification:noti];
            [array addObject:noti];
            nowTime += kOneDayInSeconds;
        }
        [self.goalEntry setIntervalNotifications:array];
    } else if (buttonIndex == kGoalButtonNone) {
        // Leave only the one notifcation on the day of
        UILocalNotification* noti = [[UILocalNotification alloc] init];
        [noti setFireDate:goalDate];
        [noti setTimeZone:[NSTimeZone defaultTimeZone]];
        [noti setAlertBody:self.goalEntry.titleString];
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
        [self.goalEntry setNotification:noti];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
