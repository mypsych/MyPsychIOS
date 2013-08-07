//
//  JournalEntry.m
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "JournalEntry.h"
#import "ProfileDataManager.h"

@implementation JournalEntry
@synthesize titleString = _titleString;
@synthesize journalString = _journalString;
@synthesize journalDate = _journalDate;
@synthesize journalFilePath = _journalFilePath;
@synthesize journalType = _journalType;

- (id)init {
    self = [super init];
    if (self) {
        self.titleString = @"Journal Entry Title";
        self.journalString = @"Write your entry here...";
        self.journalDate = [NSDate date];
        self.journalType = [NSNumber numberWithInteger:kJournalEntryText];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setTitleString:[aDecoder decodeObjectForKey:@"titleString"]];
        [self setJournalFilePath:[aDecoder decodeObjectForKey:@"journalFilePath"]];
        [self setJournalString:[aDecoder decodeObjectForKey:@"journalString"]];
        [self setJournalType:[aDecoder decodeObjectForKey:@"journalType"]];
        [self setJournalDate:[aDecoder decodeObjectForKey:@"journalDate"]];
        if (!self.journalDate) {
            NSDateComponents* comps = [aDecoder decodeObjectForKey:@"entryComps"];
            [self setJournalDate:[[NSCalendar currentCalendar] dateFromComponents:comps]];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
    [aCoder encodeObject:self.journalFilePath forKey:@"journalFilePath"];
    [aCoder encodeObject:self.journalString forKey:@"journalString"];
    [aCoder encodeObject:self.journalDate forKey:@"journalDate"];
    [aCoder encodeObject:self.journalType forKey:@"journalType"];
}

- (NSString*)stringFromDate {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    return [formatter stringFromDate:self.journalDate];
}


@end
