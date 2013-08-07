//
//  JournalEntry.h
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>

enum kJournalEntryType {
    kJournalEntryText,
    kJournalEntryVideo
};

@interface JournalEntry : NSObject <NSCoding>

@property (copy) NSString* titleString;
@property (copy) NSString* journalString;
@property (copy) NSString* journalFilePath;
@property (strong) NSDate* journalDate;
@property (strong) NSNumber* journalType;

- (NSString*)stringFromDate;

@end