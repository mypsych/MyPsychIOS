//
//  ProfileDataManager.h
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

#define WELLBEING_MINIMUM_COUNT 6
#define LIFESTYLE_MINIMUM_COUNT 6
#define PERSONAL_MINIMUM_COUNT 6
#define QUOTE_COUNT 35

#define GRAPH_DAYS_TOTAL 30
#define GRAPH_DAYS_AHEAD 4

#define MAX_DAYS_FOR_AVERAGE 10

extern int gWellbeingCategoryCount;
extern int gLifestyleCategoryCount;

extern const NSTimeInterval kOneDayInSeconds;
extern BOOL hasCompletedWellbeingBars;
extern BOOL hasCompletedLifestyleBars;
extern BOOL hasCompletedPersonalBars;

enum kMainCategoryIndex {
    kMainWellbeingIndex,
    kMainLifestlyeIndex,
    kMainPersonalIndex
};

enum kWellbeingEntryIndex {
    kWellBeingEntryYesterday,
    kWellBeingEntryToday,
    kWellBeingEntryTomorrow,
    kWellBeingEntryEnergy,
    kWellBeingEntryWeather,
    kWellBeingEntryHoursSlept,
};

enum kWellbeingEntryDefaultValue {
    kWellBeingEntryYesterdayDefaultValue  = 5,
    kWellBeingEntryTodayDefaultValue      = 5,
    kWellBeingEntryTomorrowDefaultValue   = 5,
    kWellBeingEntryEnergyDefaultValue     = 5,
    kWellBeingEntryWeatherDefaultValue    = 5,
    kWellBeingEntryHoursSleptDefaultValue = 5,
};

enum kLifestyleEntryIndex {
    kLifestyleEntryStress,
    kLifestyleEntryMood,
    kLifestyleEntryFitness,
    kLifestyleEntryNutrition,
    kLifestyleEntrySocial,
    kLifestyleEntryRelationship,
};

enum kLifestyleEntryDefaultValue {
    kLifestyleEntryStressDefaultValue       = 5,
    kLifestyleEntryMoodDefaultValue         = 5,
    kLifestyleEntryFitnessDefaultValue      = 5,
    kLifestyleEntryNutritionDefaultValue    = 5,
    kLifestyleEntrySocialDefaultValue       = 5,
    kLifestyleEntryRelationshipDefaultValue = 5,
};

enum kPersonalEntryIndex {
    kPersonalEntryOne,
    kPersonalEntryTwo,
    kPersonalEntryThree,
    kPersonalEntryFour,
    kPersonalEntryFive,
    kPersonalEntrySix,
};

enum kPersonalEntryDefaultValue {
    kPersonalEntryOneDefaultValue   = 5,
    kPersonalEntryTwoDefaultValue   = 5,
    kPersonalEntryThreeDefaultValue = 5,
    kPersonalEntryFourDefaultValue  = 5,
    kPersonalEntryFiveDefaultValue  = 5,
    kPersonalEntrySixDefaultValue   = 5,
};

extern NSString* const kWellbeingEntryIdentifiers[WELLBEING_MINIMUM_COUNT];
extern NSString* const kLifestyleEntryIdentifiers[LIFESTYLE_MINIMUM_COUNT];
extern NSString* const kMyPsychQuotes[QUOTE_COUNT];
extern NSString* const kSecurityPINStoreKey;
extern NSString* const kHasSentPersonalLabelsKey;
extern NSString* const kAppID;

@class WellbeingDataEntry;
@class LifestyleDataEntry;
@class PersonalDataEntry;
@class GoalEntry;
@class JournalEntry;
@class VideoEntry;
@class ResourceObject;
@class ChallengeObject;
@class SafetyPlanEntry;
@class SafetyPlanHeader;

@interface ProfileDataManager : NSObject

@property (strong) WellbeingDataEntry* todaysWellbeingEntry;
@property (strong) LifestyleDataEntry* todaysLifestyleEntry;
@property (strong) PersonalDataEntry* todaysPersonalEntry;
@property (strong) NSNumber* currentPsychPoints;
@property (strong) NSString* clientAccessKey; // Token for API access

+ (ProfileDataManager*)sharedManager;
+ (NSDateComponents*)dateComponentsFromStart;
+ (NSDateComponents*)dateComponentsFromDate:(NSDate*)date;
+ (NSString*)YYYYMMDDFromComponents:(NSDateComponents*)comps;
+ (BOOL)isDateComponentsEqual:(NSDateComponents*)comps1 toComps:(NSDateComponents*)comps2;
+ (void)resetBadgeAlert;
+ (NSNumber*)savedClientPin;

// API calls
- (void)loadUserAccessToken:(void (^)(NSString* key))completionBlock;
- (void)updateUserInfoWithEmail:(NSString*)email
                     withPoints:(NSNumber*)points
                  withFirstName:(NSString*)first
                   withLastName:(NSString*)lastName
                      withBlock:(void (^)(void))completionBlock;
- (void)sendMessageToDoctor:(NSNumber*)docID message:(NSString*)message withBlock:(void (^)(void))completionBlock;
- (void)loadMessagesFromDoctor:(NSNumber*)docID withBlock:(void (^)(NSArray* messages))completionBlock;
- (void)loadDoctors:(void (^)(NSArray* doctors))completionBlock;
- (void)loadForms:(void (^)(NSArray* forms))completionBlock;
- (void)loadFormWithID:(NSString*)formID withBlock:(void (^)(NSDictionary* form))completionBlock;

// safety plan API
- (void)loadSafetyPlans:(void (^)(NSArray* safetyPlans))completionBlock;
- (void)fetchSafetyPlanWithHeader:(SafetyPlanHeader*)header withBlock:(void (^)(SafetyPlanEntry *safetyPlanDetails))completionBlock;
- (void)updateSafetyPlanWithEntry:(SafetyPlanEntry*)entry
                        withBlock:(void(^)(void))completionBlock;


- (void)sendForm:(NSDictionary*)form withBlock:(void (^)(void))completionBlock;
- (void)addGoal:(GoalEntry*)entry withBlock:(void (^)(void))completionBlock;
- (void)addChallenge:(ChallengeObject*)challenge withBlock:(void (^)(void))completionBlock;
- (void)addJournalEntry:(JournalEntry*)entry withBlock:(void (^)(void))completionBlock;
- (void)addWellbeingEntry:(WellbeingDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock;
- (void)addLifestyleEntry:(LifestyleDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock;
- (void)addPersonalEntry:(PersonalDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock;
- (void)setPersonalLabelsWithBlock:(void (^)(void))completionBlock;

- (void)handleOperationError:(NSError*)error;

- (NSString*)getQuoteForIndex:(NSInteger)index;
- (NSString*)getQuote;
- (int)getQuotesUnlocked;
- (int)getPsychLevel;
- (float)getPsychLevelProgress;
- (void)addPsychPoints:(int)points;

- (void)setWellbeingGraphHidden:(BOOL)hidden withIndex:(enum kWellbeingEntryIndex)index;
- (void)setLifestyleGraphHidden:(BOOL)hidden withIndex:(enum kLifestyleEntryIndex)index;
- (void)setPersonalGraphHidden:(BOOL)hidden withIndex:(enum kPersonalEntryIndex)index;

- (BOOL)wellBeingGraphHiddenAtIndex:(enum kWellbeingEntryIndex)index;
- (BOOL)lifestyleGraphHiddenAtIndex:(enum kLifestyleEntryIndex)index;
- (BOOL)personalGraphHiddenAtIndex:(enum kPersonalEntryIndex)index;

- (CPTPlotSymbol*)symbolForIndex:(int)index;
- (CPTColor*)colorForIndex:(int)index;
- (UIColor*)uiColorForIndex:(int)index;

- (NSString *)pathForDataFile;
- (void)saveDataToDisk;
- (void)loadDataFromDisk;

- (BOOL)needsTodaysWellbeingEntry;
- (BOOL)needsTodaysLifestyleEntry;
- (BOOL)needsTodaysPersonalEntry;

- (void)addWellbeingEntry:(WellbeingDataEntry*)entry;
- (void)addLifestyleEntry:(LifestyleDataEntry*)entry;
- (void)addPersonalEntry:(PersonalDataEntry*)entry;

- (void)addResourceObject:(ResourceObject*)object;
- (void)removeResourceObject:(ResourceObject*)object;

- (void)addGoalEntry:(GoalEntry*)entry;
- (void)removeGoalEntry:(GoalEntry*)entry;

- (void)addJournalEntry:(JournalEntry*)entry;
- (void)removeJournalEntry:(JournalEntry*)entry;

- (BOOL)addChallengeObject:(ChallengeObject*)entry;
- (void)removeChallengeObject:(ChallengeObject*)entry;

- (void)addSafetyPlanEntry:(SafetyPlanEntry*)entry withBlock:(void (^)(void))completionBlock;

- (void)checkAllChallengeObjects;

- (WellbeingDataEntry*)wellbeingEntryForDate:(NSDateComponents*)dateComps;
- (LifestyleDataEntry*)lifestyleEntryForDate:(NSDateComponents*)dateComps;
- (PersonalDataEntry*)personalEntryForDate:(NSDateComponents*)dateComps;

- (void)setPersonalEntryIndetifier:(NSString*)string forIndex:(enum kPersonalEntryIndex)index;
- (NSString*)personalEntryIdentifierForIndex:(enum kPersonalEntryIndex)index;

- (WellbeingDataEntry*)wellbeingEntryForIndex:(NSInteger)index;
- (LifestyleDataEntry*)lifestyleEntryForIndex:(NSInteger)index;
- (PersonalDataEntry*)personalEntryForIndex:(NSInteger)index;

- (float)averageWellbeingAverageWithIndex:(enum kWellbeingEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date;
- (float)averageLifestyleAverageWithIndex:(enum kLifestyleEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date;
- (float)averagePersonalAverageWithIndex:(enum kPersonalEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date;

- (ResourceObject*)resourceObjectForIndex:(NSInteger)index;

- (GoalEntry*)goalEntryForIndex:(NSInteger)index;
- (JournalEntry*)journalEntryForIndex:(NSInteger)index;
- (ChallengeObject*)challengeObjectForIndex:(NSInteger)index;
- (NSInteger)resourceObjectCount;
- (NSInteger)wellbeingEntryCount;
- (NSInteger)lifestyleEntryCount;
- (NSInteger)personalEntryCount;
- (NSInteger)goalEntryCount;
- (NSInteger)journalEntryCount;
- (NSInteger)challengeObjectCount;


@end
