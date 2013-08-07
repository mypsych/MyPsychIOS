//
//  ChallengeObject.m
//  MyPsych
//
//  Created by James Lockwood on 6/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ChallengeObject.h"
#import "ProfileDataManager.h"

@implementation ChallengeObject
@synthesize challengeTypeIndex = _challengeTypeIndex;
@synthesize challengeCategoryIndex = _challengeCategoryIndex;
@synthesize challengeTargetScore = _challengeTargetScore;
@synthesize challengeOriginalScore = _challengeOriginalScore;
@synthesize challengeDateStarted = _challengeDateStarted;

- (id)init {
    self = [super init];
    if (self) {
        self.challengeTypeIndex = [NSNumber numberWithInteger:0];
        self.challengeCategoryIndex = [NSNumber numberWithInteger:0];
        self.challengeTargetScore = [NSNumber numberWithFloat:0.0f];
        self.challengeOriginalScore = [NSNumber numberWithFloat:0.0f];
        self.challengeDateStarted = [NSDate date];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setChallengeTypeIndex:[aDecoder decodeObjectForKey:@"challengeTypeIndex"]];
        [self setChallengeCategoryIndex:[aDecoder decodeObjectForKey:@"challengeCategoryIndex"]];
        [self setChallengeTargetScore:[aDecoder decodeObjectForKey:@"challengeTargetScore"]];
        [self setChallengeOriginalScore:[aDecoder decodeObjectForKey:@"challengeOriginalScore"]];
        [self setChallengeDateStarted:[aDecoder decodeObjectForKey:@"challengeDateStarted"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.challengeTypeIndex forKey:@"challengeTypeIndex"];
    [aCoder encodeObject:self.challengeCategoryIndex forKey:@"challengeCategoryIndex"];
    [aCoder encodeObject:self.challengeTargetScore forKey:@"challengeTargetScore"];
    [aCoder encodeObject:self.challengeOriginalScore forKey:@"challengeOriginalScore"];
    [aCoder encodeObject:self.challengeDateStarted forKey:@"challengeDateStarted"];
}

- (BOOL)checkChallengeCompletion {
    BOOL tryingToGoOver = YES;
    if ([self.challengeOriginalScore floatValue] > [self.challengeTargetScore floatValue]) {
        tryingToGoOver = NO;
    }
    float currentValue = 0.0f;
    if ([self.challengeTypeIndex integerValue] == kMainWellbeingIndex) {
        currentValue = [[ProfileDataManager sharedManager] averageWellbeingAverageWithIndex:[self.challengeCategoryIndex integerValue]
                                                                                    forDays:MAX_DAYS_FOR_AVERAGE
                                                                                   fromDate:[NSDate date]];
    }
    if ([self.challengeTypeIndex integerValue] == kMainLifestlyeIndex) {
        currentValue = [[ProfileDataManager sharedManager] averageLifestyleAverageWithIndex:[self.challengeCategoryIndex integerValue]
                                                                                    forDays:MAX_DAYS_FOR_AVERAGE
                                                                                   fromDate:[NSDate date]];
    }
    if ([self.challengeTypeIndex integerValue] == kMainPersonalIndex) {
        currentValue = [[ProfileDataManager sharedManager] averagePersonalAverageWithIndex:[self.challengeCategoryIndex integerValue]
                                                                                    forDays:MAX_DAYS_FOR_AVERAGE
                                                                                   fromDate:[NSDate date]];
    }
    if (tryingToGoOver && currentValue > [self.challengeTargetScore floatValue]) {
        return YES;
    }
    if (!tryingToGoOver && currentValue < [self.challengeTargetScore floatValue]) {
        return YES;
    }
    return NO;
}

@end
