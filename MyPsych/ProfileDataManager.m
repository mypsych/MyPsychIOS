//
//  ProfileDataManager.m
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ProfileDataManager.h"
#import "WellbeingDataEntry.h"
#import "LifestyleDataEntry.h"
#import "PersonalDataEntry.h"
#import "ResourceObject.h"
#import "ChallengeObject.h"
#import "GoalEntry.h"
#import "JournalEntry.h"
#import "SafetyPlanEntry.h"
#import "SafetyPlanHeader.h"
#import "MKNetworkKit.h"
#import "AppDelegate.h"
#import "NSString+Hash.h"

int gWellbeingCategoryCount = 6;
int gLifestyleCategoryCount = 6;

const NSTimeInterval kOneDayInSeconds = (24 * 60 * 60);
BOOL hasCompletedWellbeingBars = NO;
BOOL hasCompletedLifestyleBars = NO;
BOOL hasCompletedPersonalBars  = NO;

NSString* const kWellbeingEntryIdentifiers[WELLBEING_MINIMUM_COUNT] = {
    @"Yesterday",
    @"Today",
    @"Tomorrow",
    @"Energy",
    @"Weather",
    @"Hours Slept",
};

NSString* const kLifestyleEntryIdentifiers[LIFESTYLE_MINIMUM_COUNT] = {
    @"Stress",
    @"Mood",
    @"Fitness",
    @"Nutrition",
    @"Social Life",
    @"Romantic Life",
};

NSString* const kMyPsychQuotes[QUOTE_COUNT] = {
    @"The greatest wealth is health. ~Virgil",
    @"Health is a state of complete physical, mental and social well-being, and not merely the absence of disease or infirmity. ~World Health Organization, 1948",
    @"He who takes medicine and neglects to diet wastes the skill of his doctors. ~Chinese Proverb",
    @"The... patient should be made to understand that he or she must take charge of his own life. Don't take your body to the doctor as if he were a repair shop. ~Quentin Regestein",
    @"Diseases of the soul are more dangerous and more numerous than those of the body. ~Cicero",
    @"A good laugh and a long sleep are the best cures in the doctor's book. ~Irish Proverb",
    @"Water, air, and cleanliness are the chief articles in my pharmacopoeia. ~Napoleon I",
    @"The I in illness is isolation, and the crucial letters in wellness are we. ~Author unknown, as quoted in Mimi Guarneri, The Heart Speaks: A Cardiologist Reveals the Secret Language of Healing",
    @"What some call health, if purchased by perpetual anxiety about diet, isn't much better than tedious disease. ~George Dennison Prentice, Prenticeana, 1860",
    @"In a disordered mind, as in a disordered body, soundness of health is impossible. ~Cicero",
    @"I think you might dispense with half your doctors if you would only consult Dr. Sun more. ~Henry Ward Beecher",
    @"Health is a state of complete harmony of the body, mind and spirit. When one is free from physical disabilities and mental distractions, the gates of the soul open. ~B.K.S. Iyengar",
    @"Disease is somatic; the suffering from it, psychic. ~Martin H. Fischer",
    @"Health of body and mind is a great blessing, if we can bear it. ~John Henry Cardinal Newman",
    @"A healthy body is the guest-chamber of the soul; a sick, its prison. ~Francis Bacon",
    @"An imaginary ailment is worse than a disease. ~Yiddish Proverb",
    @"Health is a large word. It embraces not the body only, but the mind and spirit as well;... and not today's pain or pleasure alone, but the whole being and outlook of a man. ~James H. West",
    @"Preserving the health by too strict a regimen is a wearisome malady. ~Francois Duc de la Rochefoucauld",
    @"If man thinks about his physical or moral state he usually discovers that he is ill. ~Johann Wolfgang von Goethe",
    @"Know, then, whatever cheerful and serene supports the mind supports the body too. ~John Armstrong",
    @"The part can never be well unless the whole is well. ~Plato",
    @"The scientific truth may be put quite briefly; eat moderately, having an ordinary mixed diet, and don't worry. ~Robert Hutchison, 1932",
    @"To avoid sickness eat less; to prolong life worry less. ~Chu Hui Weng",
    @"Health and cheerfulness naturally beget each other. ~Joseph Addison",
    @"Life is not merely to be alive, but to be well. ~Marcus Valerius Martial",
    @"Confidence and hope do more good than physic. ~Galen",
    @"The mind has great influence over the body, and maladies often have their origin there. ~Moliere",
    @"Sickness is poor-spirited, and cannot serve anyone; it must husband its resources to live. But health or fullness answers its own ends, and has to spare, runs over, and inundates the neighborhoods and creeks of other men's necessities. ~Ralph Waldo Emerson",
    @"He who has health has hope; and he who has hope has everything. ~Arabic Proverb",
    @"A bodily disease, which we look upon as whole and entire within itself, may, after all, be but a symptom of some ailment in the spiritual part. ~Nathaniel Hawthorne, The Scarlet Letter",
    @"Happiness lies, first of all, in health. ~George William Curtis, Lotus-Eating",
    @"Nothing is more fatal to Health, than an over Care of it. ~Benjamin Franklin",
    @"Being entirely honest with oneself is a good exercise. ~Sigmund Freud",
    @"Man should not strive to eliminate his complexes, but to get in accord with them; they are legitimately what directs his contact in the world. ~Sigmund Freud",
    @"Just as a cautious businessman avoids investing all his capital in one concern, so wisdom would probably admonish us also not to anticipate all our happiness from one quarter alone. ~Sigmund Freud"
};

NSString* const kQuoteStoredKey = @"quoteStoredKey";
NSString* const kSecurityPINStoreKey = @"pinPasscodeID";
NSString* const kHasSentPersonalLabelsKey = @"kHasSentPersonalLabelsKey";
NSString* const kAppID = @"529223913";
NSString* const kDateStartIdentifier = @"dateStartID";
NSString* const kResourceStorageKey = @"customResourceArray";
NSString* const kHostnamePath = @"www.mypsychtes.com/api";
// TESTING STAGE: mypsych.stage.appicstudios.com/api
// PRODUCTION: www.mypsychtes.com/api

@interface ProfileDataManager ()
@property (strong) NSArray* wellbeingDataArray;
@property (strong) NSArray* lifestyleDataArray;
@property (strong) NSArray* personalDataArray;
@property (strong) NSArray* resourceArray;
@property (strong) NSArray* goalArray;
@property (strong) NSArray* journalArray;
@property (strong) NSArray* challengeArray;
@property (strong) NSMutableArray* wellbeingGraphHidden;
@property (strong) NSMutableArray* lifestyleGraphHidden;
@property (strong) NSMutableArray* personalGraphHidden;
@property (strong) NSMutableArray* personalEntryIdentifiers;
@property (strong) MKNetworkEngine* networkEngine;

- (void)loginCurrentUser:(void (^)(NSString* userKey))completionBlock;
- (void)createClientWithFirstName:(NSString*)first withLastName:(NSString*)last withEmail:(NSString*)email withBlock:(void (^)(NSInteger client_id))completionBlock;
- (void)setPINForCurrentUser:(void (^)(BOOL success))completionBlock;

@end

@implementation ProfileDataManager
@synthesize todaysWellbeingEntry = _todaysWellbeingEntry;
@synthesize todaysLifestyleEntry = _todaysLifestyleEntry;
@synthesize todaysPersonalEntry = _todaysPersonalEntry;
@synthesize wellbeingDataArray = _wellbeingDataArray;
@synthesize lifestyleDataArray = _lifestyleDataArray;
@synthesize resourceArray = _resourceArray;
@synthesize goalArray = _goalArray;
@synthesize journalArray = _journalArray;
@synthesize challengeArray = _challengeArray;
@synthesize wellbeingGraphHidden = _wellbeingGraphHidden;
@synthesize lifestyleGraphHidden = _lifestyleGraphHidden;
@synthesize personalDataArray = _personalDataArray;
@synthesize personalGraphHidden = _personalGraphHidden;
@synthesize personalEntryIdentifiers = _personalEntryIdentifiers;
@synthesize currentPsychPoints = _currentPsychPoints;
@synthesize networkEngine = _networkEngine;

+ (ProfileDataManager*)sharedManager {
    static ProfileDataManager *sharedSingleton = nil;
    @synchronized(self) {
        if (!sharedSingleton) {
            sharedSingleton = [[ProfileDataManager alloc] init];
        }
        return sharedSingleton;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        // Load todays entries if they exist
        self.todaysLifestyleEntry = nil;
        self.todaysWellbeingEntry = nil;
        self.todaysPersonalEntry = nil;
        
        self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:kHostnamePath];
        
        self.wellbeingDataArray = [NSArray array];
        self.lifestyleDataArray = [NSArray array];
        self.personalDataArray = [NSArray array];
        self.goalArray = [NSArray array];
        self.journalArray = [NSArray array];
        self.personalEntryIdentifiers = [NSMutableArray array];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSDate* date = [defaults objectForKey:kDateStartIdentifier];
        if (!date) {
            [defaults setObject:[NSDate date] forKey:kDateStartIdentifier];
        }
        
        // TESTING - Load key for API use
        self.clientAccessKey = nil;
        [self loadUserAccessToken:^(NSString *key) {
            self.clientAccessKey = key;
        }];
    }
    return self;
}

+ (NSDateComponents*)dateComponentsFromStart {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [ProfileDataManager dateComponentsFromDate:[defaults objectForKey:kDateStartIdentifier]];
}

+ (NSDateComponents*)dateComponentsFromDate:(NSDate*)date {
    if (date) {
        return [[NSCalendar currentCalendar] components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    }
    return nil;
}

+ (NSString*)YYYYMMDDFromComponents:(NSDateComponents*)comps {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    return [formatter stringFromDate:date];
}

+ (BOOL)isDateComponentsEqual:(NSDateComponents*)comps1 toComps:(NSDateComponents*)comps2 {
    return (comps1.day == comps2.day &&
            comps1.month == comps2.month &&
            comps1.year == comps2.year);
}

+ (void)resetBadgeAlert {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"badgeAlert.mypsych"];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    NSDictionary* rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    UILocalNotification* notification = [rootObject valueForKey:@"badgeNotification"];
    
    if (!notification) {
        notification = [[UILocalNotification alloc] init];
    } else {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
    notification.applicationIconBadgeNumber = 1;
    notification.fireDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    NSMutableDictionary* newRootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:notification forKey:@"badgeNotification"];
    [NSKeyedArchiver archiveRootObject:newRootObject toFile:filename];
}

// Will return a new PIN if there isn't one saved already
+ (NSNumber*)savedClientPin {
    NSNumber* savedPin = [[NSUserDefaults standardUserDefaults] objectForKey:kClientPINStoreKey];
    if (!savedPin) {
        // NSString* udidString = [[NSUserDefaults standardUserDefaults] objectForKey:kUDIDStoreKey];
        long long min = 10000000000;
        savedPin = [NSNumber numberWithLongLong:min + arc4random_uniform(1000000000)];
        // NSUInteger boundedhash = ([udidString hash] / (1 << 16)) + (arc4random() % 1024);
        // savedPin = [NSNumber numberWithUnsignedInteger:boundedhash];
    }
    return savedPin;
}

- (void)loginCurrentUser:(void (^)(NSString* userKey))completionBlock {
    NSString* udid = [[NSUserDefaults standardUserDefaults] objectForKey:kUDIDStoreKey];
    NSString* username = udid;
    NSString* password = udid;
    
    NSString* path = [NSString stringWithFormat:@"auth/login/%@/%@/", username, [password SHA1]];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:nil
                                                        httpMethod:@"POST"];
    
    [op setPostDataEncoding:MKNKPostDataEncodingTypeURL];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = [completedOperation responseJSON];
        NSString* key = nil;
        if ([[dict objectForKey:@"success"] integerValue] == 1) {
            key = [dict objectForKey:@"key"];
        }
        if (completionBlock) { completionBlock(key); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
    
}

- (void)createClientWithFirstName:(NSString*)first withLastName:(NSString*)last withEmail:(NSString*)email withBlock:(void (^)(NSInteger client_id))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:first forKey:@"firstname"];
    [params setObject:last  forKey:@"lastname"];
    [params setObject:email forKey:@"email"];
    
    NSString* udid = [[NSUserDefaults standardUserDefaults] objectForKey:kUDIDStoreKey];
    NSLog(@"UDID:%@", udid);
    [params setObject:udid forKey:@"username"];
    [params setObject:[udid SHA1] forKey:@"password"];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"clients/create/"
                                                            params:params
                                                        httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        NSLog(@"JSON Resonse when making key:%@", dict);
        NSInteger clientID = -1;
        if ([[dict objectForKey:@"success"] integerValue] == 1) {
            clientID = [[dict objectForKey:@"id"] integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:clientID forKey:kClientIDStoreKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if (completionBlock) { completionBlock(clientID); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(-1); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)setPINForCurrentUser:(void (^)(BOOL success))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber* pinNumber = [ProfileDataManager savedClientPin];
    NSString* pin = [formatter stringFromNumber:pinNumber];
    [params setObject:pin forKey:@"pin"];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"clients/pin/create/"
                                                            params:params
                                                        httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        if ([[dict objectForKey:@"success"] integerValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:pinNumber forKey:kClientPINStoreKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (completionBlock) { completionBlock(YES); }
        } else {
            if (completionBlock) { completionBlock(NO); }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(NO); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)loadUserAccessToken:(void (^)(NSString* token))completionBlock {
    [self loginCurrentUser:^(NSString *userKey) {
        if (!userKey) {
            // Needs to create an account!
            [self createClientWithFirstName:@"<newuser>" withLastName:@"<newuser>" withEmail:@"<newuser@mail.com>" withBlock:^(NSInteger client_id) {
                NSLog(@"ID: %i", client_id);
                [self loginCurrentUser:^(NSString *userKey) {
                     NSLog(@"%@", userKey);
                    if (completionBlock) { completionBlock(userKey); }
                }];
            }];
        } else {
            // Logged in and ready to go!
            // NSLog(@"%@", userKey);
            if (completionBlock) { completionBlock(userKey); }
        }
    }];
}

- (void)updateUserInfoWithEmail:(NSString*)email
                     withPoints:(NSNumber*)points
                  withFirstName:(NSString*)first
                   withLastName:(NSString*)lastName
                      withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    [params setObject:first forKey:@"firstname"];
    [params setObject:lastName forKey:@"lastname"];
    [params setObject:email forKey:@"email"];
    
    NSString* udid = [[NSUserDefaults standardUserDefaults] objectForKey:kUDIDStoreKey];
    [params setObject:udid forKey:@"username"];
    [params setObject:[udid SHA1] forKey:@"password"];
    
    NSInteger clientID = [[NSUserDefaults standardUserDefaults] integerForKey:kClientIDStoreKey];
    NSString* path = [NSString stringWithFormat:@"clients/update/%d", clientID];
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:kClientPINStoreKey]) {
            [self setPINForCurrentUser:^(BOOL success) {
                if (completionBlock) { completionBlock(); }
            }];
        } else {
            if (completionBlock) { completionBlock(); }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)sendMessageToDoctor:(NSNumber*)docID message:(NSString*)message withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    [params setObject:message forKey:@"message"];
    
    NSString* path = [NSString stringWithFormat:@"messages/create/%d/", [docID integerValue]];
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)loadMessagesFromDoctor:(NSNumber*)docID withBlock:(void (^)(NSArray* messages))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    NSString* path = [NSString stringWithFormat:@"messages/listing/%d/", [docID integerValue]];
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSArray* array = [[completedOperation responseJSON] objectForKey:@"data"];
        if (completionBlock) { completionBlock(array); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)loadDoctors:(void (^)(NSArray* doctors))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"professionals/listing/"
                                                            params:params
                                                        httpMethod:@"POST"];
    
    [op setPostDataEncoding:MKNKPostDataEncodingTypeURL];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = [completedOperation responseJSON];
        NSArray* doctorArray = [dict objectForKey:@"data"];
        if (completionBlock) { completionBlock(doctorArray); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)loadForms:(void (^)(NSArray* forms))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    NSLog(@"Load Forms Parameters:%@", params);
    
    NSNumber* clientID = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIDStoreKey];
    NSString* path = [NSString stringWithFormat:@"clients/forms/listing/%d/", [clientID integerValue]];
    NSLog(@"Fetch Forms path:%@", path);
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        NSArray* forms = [dict objectForKey:@"data"];
        if (completionBlock) { completionBlock(forms); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)loadSafetyPlans:(void (^)(NSArray* safetyPlans))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    NSLog(@"Load Safety Plans Parameters:%@", params);
    
    NSNumber* clientID = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIDStoreKey];
    NSString* path = [NSString stringWithFormat:@"clients/safetyPlans/listing/%d/", [clientID integerValue]];
    
    NSLog(@"Fetch Safety Plans path:%@", path);
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        NSArray* safetyPlans = [dict objectForKey:@"data"];
        NSLog(@"list:%@", safetyPlans);
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *object in safetyPlans) {
            SafetyPlanHeader *safetyPlan = [[SafetyPlanHeader alloc] initWithDictionary:object];
            [list addObject:safetyPlan];
        }
        safetyPlans = [NSArray arrayWithArray:list];
        if (completionBlock) { completionBlock(safetyPlans); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)fetchSafetyPlanWithHeader:(SafetyPlanHeader*)header withBlock:(void (^)(SafetyPlanEntry *safetyPlanDetails))completionBlock {

    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    NSString* path = [NSString stringWithFormat:@"clients/safetyPlans/read/%i/",  [header.identifier integerValue]];
    
    NSLog(@"Fetch Safety Plans path:%@", path);
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict    = [completedOperation responseJSON];
        NSArray *list         = [dict objectForKey:@"data"];
        NSDictionary *details = [list objectAtIndex:0];
        
        // parse escaped json
        NSString * string = [details objectForKey:@"plan_json_data"];
        
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"  " withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@";" withString:@","];
        string = [string stringByReplacingOccurrencesOfString:@" = " withString:@":"];
        string = [string stringByReplacingOccurrencesOfString:@";" withString:@","];

        //string = [NSString stringWithFormat:@"%@%@",[string substringWithRange:NSMakeRange(0, [string length]-2)], [string substringFromIndex:string.length-1]];
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSLog(@"String:%@", string);
        
        //NSData *data = [[NSData alloc] initWithContentsOfMappedFile:test];
        
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Data:%@", data);

        NSDictionary *innerJson = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingMutableLeaves
                                                                    error:nil];
        NSLog(@"Dictionary:%@",innerJson);
        
        //id planData = [NSJSONSerialization JSONObjectWithData:[details objectForKey:@"plan_json_data"] options:0 error:nil];
        
        // NSLog(@"Parse attempt:%@", planData);
        
        
        SafetyPlanEntry *safetyPlanDetails = [[SafetyPlanEntry alloc] initWithDictionary:innerJson forPlanNamed:header.name];
    
        if (completionBlock) { completionBlock(safetyPlanDetails); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}


- (void)loadFormWithID:(NSString*)formID withBlock:(void (^)(NSDictionary* form))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    NSString* path = [NSString stringWithFormat:@"forms/read/%@/", formID];
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        if (completionBlock) { completionBlock([dict objectForKey:@"data"]); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(nil); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)sendForm:(NSDictionary*)form withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    NSData* data = [NSJSONSerialization dataWithJSONObject:[form objectForKey:@"answers"]
                                                   options:0
                                                     error:nil];
    NSString* answerStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:answerStr forKey:@"answers"];
    
    NSString* formID = [form objectForKey:@"id"];
    NSString* path = [NSString stringWithFormat:@"forms/answers/create/%@/", formID];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setPostDataEncoding:MKNKPostDataEncodingTypeURL];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        // NSLog(@"%@", [completedOperation responseJSON]);
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addSafetyPlanEntry:(SafetyPlanEntry*)entry withBlock:(void (^)(void))completionBlock  {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:[entry getDictionaryFromEntry] options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:json forKey:@"plan_json_data"];
    [params setObject:entry.planeName forKey:@"plan_name"];
    
    NSLog(@"Add parameters:%@", params);
    
    NSNumber* clientID = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIDStoreKey];
    NSString *path = [NSString stringWithFormat:@"clients/safetyPlans/create/%i", [clientID integerValue]];
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)updateSafetyPlanWithEntry:(SafetyPlanEntry*)entry
                        withBlock:(void(^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:[entry getDictionaryFromEntry] options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [params setObject:json forKey:@"plan_json_data"];

    [params setObject:entry.planeName forKey:@"plan_name"];
    
    //NSNumber* clientID = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIDStoreKey];
    NSString *path = [NSString stringWithFormat:@"clients/safetyPlans/update/%i", [entry.recordIdentifier intValue]];
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}


- (void)addGoal:(GoalEntry*)entry withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    [params setObject:entry.goalString forKey:@"body"];
    [params setObject:entry.titleString forKey:@"title"];
    [params setObject:[ProfileDataManager YYYYMMDDFromComponents:entry.dueDateComps] forKey:@"due_date"];
    
    NSLog(@"Add Goal Parameters:%@", params);
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"clients/goals/create/"
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); } 
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addChallenge:(ChallengeObject*)challenge withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:challenge.challengeCategoryIndex forKey:@"category_index"];
    [params setObject:challenge.challengeTargetScore forKey:@"target_score"];
    [params setObject:challenge.challengeOriginalScore forKey:@"original_score"];
    
    if ([challenge.challengeTypeIndex integerValue] == kMainWellbeingIndex) {
        [params setObject:@"wellbeing" forKey:@"type"];
    } else if ([challenge.challengeTypeIndex integerValue] == kMainLifestlyeIndex) {
        [params setObject:@"lifestyle" forKey:@"type"];
    } else if ([challenge.challengeTypeIndex integerValue] == kMainPersonalIndex) {
        [params setObject:@"personal" forKey:@"type"];
    }
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"clients/challenges/create/"
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addJournalEntry:(JournalEntry*)entry withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:entry.journalString forKey:@"body"];
    [params setObject:entry.titleString forKey:@"title"];
    if ([entry.journalType integerValue] == kJournalEntryText) {
        [params setObject:@"text" forKey:@"type"];
    } else if ([entry.journalType integerValue] == kJournalEntryVideo) {
        [params setObject:@"video" forKey:@"type"];
        return;
    }
    
    MKNetworkOperation* op = [self.networkEngine operationWithPath:@"clients/journal/create/"
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setPostDataEncoding:MKNKPostDataEncodingTypeURL];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addWellbeingEntry:(WellbeingDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:[ProfileDataManager YYYYMMDDFromComponents:entry.entryDateComps] forKey:@"date"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryEnergy] forKey:@"energy"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryHoursSlept] forKey:@"hours_slept"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryToday] forKey:@"today"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryWeather] forKey:@"weather"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryTomorrow] forKey:@"tomorrow"];
    [params setObject:[entry numberWithIndex:kWellBeingEntryYesterday] forKey:@"yesterday"];
    
    NSString* path = update ? [NSString stringWithFormat:@"clients/wellbeing/update/%d", [entry.apiEntryID integerValue]] : @"clients/wellbeing/create/";
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        if ([dict objectForKey:@"id"]) {
            entry.apiEntryID = [dict objectForKey:@"id"];
        }
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addLifestyleEntry:(LifestyleDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:[ProfileDataManager YYYYMMDDFromComponents:entry.entryDateComps] forKey:@"date"];
    [params setObject:[entry numberWithIndex:kLifestyleEntryFitness] forKey:@"fitness"];
    [params setObject:[entry numberWithIndex:kLifestyleEntryStress] forKey:@"stress"];
    [params setObject:[entry numberWithIndex:kLifestyleEntryRelationship] forKey:@"romantic_life"];
    [params setObject:[entry numberWithIndex:kLifestyleEntryMood] forKey:@"mood"];
    [params setObject:[entry numberWithIndex:kLifestyleEntrySocial] forKey:@"social_life"];
    [params setObject:[entry numberWithIndex:kLifestyleEntryNutrition] forKey:@"nutrition"];
    
    NSString* path = update ? [NSString stringWithFormat:@"clients/lifestyle/update/%d", [entry.apiEntryID integerValue]] : @"clients/lifestyle/create/";
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        if ([dict objectForKey:@"id"]) {
            entry.apiEntryID = [dict objectForKey:@"id"];
        }
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)addPersonalEntry:(PersonalDataEntry*)entry withUpdate:(BOOL)update withBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:[ProfileDataManager YYYYMMDDFromComponents:entry.entryDateComps] forKey:@"date"];
    [params setObject:[entry numberWithIndex:kPersonalEntryOne] forKey:@"stat1"];
    [params setObject:[entry numberWithIndex:kPersonalEntryTwo] forKey:@"stat2"];
    [params setObject:[entry numberWithIndex:kPersonalEntryThree] forKey:@"stat3"];
    [params setObject:[entry numberWithIndex:kPersonalEntryFour] forKey:@"stat4"];
    [params setObject:[entry numberWithIndex:kPersonalEntryFive] forKey:@"stat5"];
    [params setObject:[entry numberWithIndex:kPersonalEntrySix] forKey:@"stat6"];
    
    NSString* path = update ? [NSString stringWithFormat:@"clients/personal/update/%d", [entry.apiEntryID integerValue]] : @"clients/personal/create/";
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        NSDictionary* dict = [completedOperation responseJSON];
        if ([dict objectForKey:@"id"]) {
            entry.apiEntryID = [dict objectForKey:@"id"];
        }
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self setPersonalLabelsWithBlock:nil];
    [self.networkEngine enqueueOperation:op];
}

- (void)setPersonalLabelsWithBlock:(void (^)(void))completionBlock {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.clientAccessKey forKey:@"key"];
    
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntryOne] forKey:@"stat1"];
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntryTwo] forKey:@"stat2"];
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntryThree] forKey:@"stat3"];
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntryFour] forKey:@"stat4"];
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntryFive] forKey:@"stat5"];
    [params setObject:[self personalEntryIdentifierForIndex:kPersonalEntrySix] forKey:@"stat6"];
    
    BOOL update = ![[NSUserDefaults standardUserDefaults] boolForKey:kHasSentPersonalLabelsKey];
    NSString* path = update ? @"clients/personal_labels/create/" : @"clients/personal_labels/update/";
    MKNetworkOperation* op = [self.networkEngine operationWithPath:path
                                                            params:params
                                                        httpMethod:@"POST"];
    
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@", [completedOperation responseJSON]);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kHasSentPersonalLabelsKey];
        if (completionBlock) { completionBlock(); }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self handleOperationError:error];
        if (completionBlock) { completionBlock(); }
    }];
    
    [self.networkEngine enqueueOperation:op];
}

- (void)handleOperationError:(NSError*)error {
    NSLog(@"%@", [error localizedDescription]);
    /*
     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:[error localizedDescription]
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     */
}

- (NSString*)getQuoteForIndex:(NSInteger)index {
    index = index % QUOTE_COUNT;
    return kMyPsychQuotes[index];
}

- (NSString*)getQuote {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int currentQuoteIndex = [defaults integerForKey:kQuoteStoredKey];
    if (currentQuoteIndex == QUOTE_COUNT - 1) {
        [defaults setBool:YES forKey:@"unlockedAllQuotes"];
    }
    int newIndex = (currentQuoteIndex + 1) % QUOTE_COUNT;
    [defaults setInteger:newIndex forKey:kQuoteStoredKey];
    [defaults synchronize];
    return kMyPsychQuotes[currentQuoteIndex];
}

- (int)getQuotesUnlocked {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"unlockedAllQuotes"]) {
        return QUOTE_COUNT;
    }
    return [defaults integerForKey:kQuoteStoredKey];
}

- (int)getPsychLevel {
    float levelf = log2f([[self currentPsychPoints] floatValue]);
    return floorf(levelf);
}

- (float)getPsychLevelProgress {
    return [self.currentPsychPoints floatValue] / 3.0f;
}

- (void)addPsychPoints:(int)points {
    self.currentPsychPoints = [NSNumber numberWithInt:[self.currentPsychPoints intValue] + points];
}

- (void)setWellbeingGraphHidden:(BOOL)hidden withIndex:(enum kWellbeingEntryIndex)index {
    if (self.wellbeingGraphHidden) {
        [self.wellbeingGraphHidden replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:hidden]];
    }
}

- (void)setLifestyleGraphHidden:(BOOL)hidden withIndex:(enum kLifestyleEntryIndex)index {
    if (self.lifestyleGraphHidden) {
        [self.lifestyleGraphHidden replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:hidden]];
    }
}

- (void)setPersonalGraphHidden:(BOOL)hidden withIndex:(enum kPersonalEntryIndex)index {
    if (self.personalGraphHidden) {
        [self.personalGraphHidden replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:hidden]];
    }
}

- (BOOL)wellBeingGraphHiddenAtIndex:(enum kWellbeingEntryIndex)index {
    if (self.wellbeingGraphHidden) {
        return [[self.wellbeingGraphHidden objectAtIndex:index] boolValue];
    }
    return NO;
}

- (BOOL)lifestyleGraphHiddenAtIndex:(enum kLifestyleEntryIndex)index {
    if (self.lifestyleGraphHidden) {
        return [[self.lifestyleGraphHidden objectAtIndex:index] boolValue];
    }
    return NO;
}

- (BOOL)personalGraphHiddenAtIndex:(enum kPersonalEntryIndex)index {
    if (self.personalGraphHidden) {
        return [[self.personalGraphHidden objectAtIndex:index] boolValue];
    }
    return NO;
}

- (CPTPlotSymbol*)symbolForIndex:(int)index {
    return [CPTPlotSymbol ellipsePlotSymbol];
}

- (CPTColor*)colorForIndex:(int)index {
    return [CPTColor colorWithCGColor:[[self uiColorForIndex:index] CGColor]];
}

- (UIColor*)uiColorForIndex:(int)index {
    int modIndex = index % 9;
    if (modIndex == 0) { return [UIColor brownColor]; }
    if (modIndex == 1) { return [UIColor redColor]; }
    if (modIndex == 2) { return [UIColor greenColor]; }
    if (modIndex == 3) { return [UIColor yellowColor]; }
    if (modIndex == 4) { return [UIColor cyanColor]; }
    if (modIndex == 5) { return [UIColor blueColor]; }
    if (modIndex == 6) { return [UIColor magentaColor]; }
    if (modIndex == 7) { return [UIColor orangeColor]; }
    if (modIndex == 8) { return [UIColor purpleColor]; }
    return [UIColor grayColor];
}

- (NSString *)pathForDataFile {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"savedData.mypsych"];
    return filename;
}

- (void)saveDataToDisk {
    NSString * path = [self pathForDataFile];
    NSMutableDictionary* rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue: [self wellbeingDataArray] forKey:@"wellbeingDataArray"];
    [rootObject setValue: [self lifestyleDataArray] forKey:@"lifestyleDataArray"];
    [rootObject setValue: [self personalDataArray] forKey:@"personalDataArray"];
    [rootObject setValue: [self wellbeingGraphHidden] forKey:@"wellbeingGraphHidden"];
    [rootObject setValue: [self lifestyleGraphHidden] forKey:@"lifestyleGraphHidden"];
    [rootObject setValue: [self personalGraphHidden] forKey:@"personalGraphHidden"];
    [rootObject setValue: [self resourceArray] forKey:@"resourceArray"];
    [rootObject setValue: [self goalArray] forKey:@"goalArray"];
    [rootObject setValue: [self journalArray] forKey:@"journalArray"];
    [rootObject setValue: [self challengeArray] forKey:@"challengeArray"];
    [rootObject setValue: [self personalEntryIdentifiers] forKey:@"personalEntryIdentifiers"];
    [rootObject setValue: [self currentPsychPoints] forKey:@"currentPsychPoints"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (void)loadDataFromDisk {
    NSString* path = [self pathForDataFile];
    NSDictionary* rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self setWellbeingDataArray:[rootObject       valueForKey:@"wellbeingDataArray"]];
    [self setLifestyleDataArray:[rootObject       valueForKey:@"lifestyleDataArray"]];
    [self setPersonalDataArray:[rootObject        valueForKey:@"personalDataArray"]];
    [self setWellbeingGraphHidden:[rootObject     valueForKey:@"wellbeingGraphHidden"]];
    [self setLifestyleGraphHidden:[rootObject     valueForKey:@"lifestyleGraphHidden"]];
    [self setPersonalGraphHidden:[rootObject      valueForKey:@"personalGraphHidden"]];
    [self setResourceArray:[rootObject            valueForKey:@"resourceArray"]];
    [self setGoalArray:[rootObject                valueForKey:@"goalArray"]];
    [self setPersonalEntryIdentifiers:[rootObject valueForKey:@"personalEntryIdentifiers"]];
    [self setCurrentPsychPoints:[rootObject       valueForKey:@"currentPsychPoints"]];
    [self setJournalArray:[rootObject             valueForKey:@"journalArray"]];
    [self setChallengeArray:[rootObject           valueForKey:@"challengeArray"]];
    
    if (!self.wellbeingDataArray) {
        self.wellbeingDataArray = [NSArray array];
    }
    if (!self.lifestyleDataArray) {
        self.lifestyleDataArray = [NSArray array];
    }
    if (!self.personalDataArray) {
        self.personalDataArray = [NSArray array];
    }
    if (!self.resourceArray) {
        NSMutableArray* defaultArray = [NSMutableArray array];
        ResourceObject* default1     = [[ResourceObject alloc] init];
        default1.resourceTitle       = @"The Samaritans";
        default1.resourceURL         = @"http://samaritanshope.org/";
        [defaultArray addObject:default1];
        
        ResourceObject* default2 = [[ResourceObject alloc] init];
        default2.resourceTitle   = @"Suicide Prevention Hotline";
        default2.resourceURL     = @"http://www.suicidepreventionlifeline.org/";
        [defaultArray addObject:default2];
        
        ResourceObject* default3 = [[ResourceObject alloc] init];
        default3.resourceTitle   = @"Active Minds";
        default3.resourceURL     = @"http://www.activeminds.org/";
        [defaultArray addObject:default3];
        
        ResourceObject* default4 = [[ResourceObject alloc] init];
        default4.resourceTitle   = @"Visit the MyPsych Website";
        default4.resourceURL     = @"http://www.my-psych.com";
        [defaultArray addObject:default4];
        
        self.resourceArray = defaultArray;
    }
    if (!self.personalEntryIdentifiers) {
        self.personalEntryIdentifiers = [NSMutableArray array];
        for (int i = 0; i < PERSONAL_MINIMUM_COUNT; i++) {
            [self.personalEntryIdentifiers addObject:[NSString stringWithFormat:@"Personal %i", i+1]];
        }
    }
    if (!self.wellbeingGraphHidden) {
        self.wellbeingGraphHidden = [NSMutableArray array];
        for (int i = 0; i < WELLBEING_MINIMUM_COUNT; i++) {
            [self.wellbeingGraphHidden addObject:[NSNumber numberWithBool:NO]];
        }
    }
    if (!self.lifestyleGraphHidden) {
        self.lifestyleGraphHidden = [NSMutableArray array];
        for (int i = 0; i < LIFESTYLE_MINIMUM_COUNT; i++) {
            [self.lifestyleGraphHidden addObject:[NSNumber numberWithBool:NO]];
        }
    }
    if (!self.personalGraphHidden) {
        self.personalGraphHidden = [NSMutableArray array];
        for (int i = 0; i < PERSONAL_MINIMUM_COUNT; i++) { // Initially all hidden
            [self.personalGraphHidden addObject:[NSNumber numberWithBool:NO]];
        }
    }
    if (!self.goalArray) {
        self.goalArray = [NSArray array];
    }
    if (!self.journalArray) {
        self.journalArray = [NSArray array];
    }
    if (!self.challengeArray) {
        self.challengeArray = [NSArray array];
    }
    if (!self.currentPsychPoints) {
        self.currentPsychPoints = [NSNumber numberWithInt:0];
    }
    
    // Check if the day is current, and set the current entries
    NSDateComponents* todayComps = [ProfileDataManager dateComponentsFromDate:[NSDate date]];
    WellbeingDataEntry* lastwbEntry = [self.wellbeingDataArray lastObject];
    if (lastwbEntry) {
        if ([ProfileDataManager isDateComponentsEqual:todayComps toComps:lastwbEntry.entryDateComps]) {
            self.todaysWellbeingEntry = lastwbEntry;
            hasCompletedWellbeingBars = YES;
        } else {
            hasCompletedWellbeingBars = NO;
        }
    }
    
    LifestyleDataEntry* lastlsEntry = [self.lifestyleDataArray lastObject];
    if (lastlsEntry) {
        if ([ProfileDataManager isDateComponentsEqual:todayComps toComps:lastwbEntry.entryDateComps]) {
            self.todaysLifestyleEntry = lastlsEntry;
            hasCompletedLifestyleBars = YES;
        } else {
            hasCompletedLifestyleBars = NO;
        }
    }
    
    PersonalDataEntry* lastprEntry = [self.personalDataArray lastObject];
    if (lastprEntry) {
        if ([ProfileDataManager isDateComponentsEqual:todayComps toComps:lastprEntry.entryDateComps]) {
            self.todaysPersonalEntry = lastprEntry;
            hasCompletedPersonalBars = YES;
        } else {
            hasCompletedPersonalBars = NO;
        }
    }
}

- (BOOL)needsTodaysWellbeingEntry {
    return (self.todaysWellbeingEntry == nil);
}

- (BOOL)needsTodaysLifestyleEntry {
    return (self.todaysLifestyleEntry == nil);
}

- (BOOL)needsTodaysPersonalEntry {
    return (self.todaysPersonalEntry == nil);
}

- (void)addWellbeingEntry:(WellbeingDataEntry*)entry {
    NSMutableArray* newArray = [self.wellbeingDataArray mutableCopy];
    [newArray addObject:entry];
    self.wellbeingDataArray = newArray;
}

- (void)addLifestyleEntry:(LifestyleDataEntry*)entry {
    NSMutableArray* newArray = [self.lifestyleDataArray mutableCopy];
    [newArray addObject:entry];
    self.lifestyleDataArray = newArray;
}

- (void)addPersonalEntry:(PersonalDataEntry*)entry {
    NSMutableArray* newArray = [self.personalDataArray mutableCopy];
    [newArray addObject:entry];
    self.personalDataArray = newArray;
}

- (void)addResourceObject:(ResourceObject*)object {
    NSMutableArray* newArray = [self.resourceArray mutableCopy];
    [newArray addObject:object];
    self.resourceArray = newArray;
}

- (void)removeResourceObject:(ResourceObject*)object {
    NSMutableArray* newArray = [self.resourceArray mutableCopy];
    [newArray removeObject:object];
    self.resourceArray = newArray;
}

- (void)addGoalEntry:(GoalEntry*)entry {
    NSMutableArray* newArray = [self.goalArray mutableCopy];
    [newArray addObject:entry];
    if (self.clientAccessKey) {
        [self addGoal:entry withBlock:nil];
    }
    self.goalArray = newArray;
}

- (void)addSafetyPlanEntry:(SafetyPlanEntry*)entry {
    [self addSafetyPlanEntry:entry withBlock:nil];
}


- (void)removeGoalEntry:(GoalEntry*)entry {
    NSMutableArray* newArray = [self.goalArray mutableCopy];
    [newArray removeObject:entry];
    self.goalArray = newArray;
}

- (void)addJournalEntry:(JournalEntry*)entry {
    NSMutableArray* newArray = [self.journalArray mutableCopy];
    [newArray insertObject:entry atIndex:0];
    if (self.clientAccessKey) {
        [self addJournalEntry:entry withBlock:nil];
    }
    self.journalArray = newArray;
}

- (void)removeJournalEntry:(JournalEntry*)entry {
    NSMutableArray* newArray = [self.journalArray mutableCopy];
    [newArray removeObject:entry];
    self.journalArray = newArray;
}

- (BOOL)addChallengeObject:(ChallengeObject*)entry {
    NSMutableArray* newArray = [self.challengeArray mutableCopy];
    for (ChallengeObject* object in newArray) {
        if ([object.challengeTypeIndex integerValue] == [entry.challengeTypeIndex integerValue] &&
            [object.challengeCategoryIndex integerValue] == [entry.challengeCategoryIndex integerValue]) {
            return NO;
        }
    }
    [newArray insertObject:entry atIndex:0];
    if (self.clientAccessKey) {
        [self addChallenge:entry withBlock:nil];
    }
    self.challengeArray = newArray;
    return YES;
}

- (void)removeChallengeObject:(ChallengeObject*)entry {
    NSMutableArray* newArray = [self.challengeArray mutableCopy];
    [newArray removeObject:entry];
    self.challengeArray = newArray;
}

- (void)checkAllChallengeObjects {
    for (int i = 0; i < [self.challengeArray count]; i++) {
        ChallengeObject* object = [self.challengeArray objectAtIndex:i];
        if ([object checkChallengeCompletion]) {
            NSString* category = nil;
            if ([object.challengeTypeIndex integerValue] == kMainWellbeingIndex) {
                category = kWellbeingEntryIdentifiers[object.challengeCategoryIndex.integerValue];
            }
            if ([object.challengeTypeIndex integerValue] == kMainLifestlyeIndex) {
                category = kLifestyleEntryIdentifiers[object.challengeCategoryIndex.integerValue];
            }
            if ([object.challengeTypeIndex integerValue] == kMainPersonalIndex) {
                category = [self personalEntryIdentifierForIndex:object.challengeCategoryIndex.integerValue];
            }
            NSString* message = [NSString stringWithFormat:@"You've reached your \"%@\" target of %.1f, here's a MyPsych point!",
                                 category, [object.challengeTargetScore floatValue]];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self addPsychPoints:1];
            [self removeChallengeObject:object];
        }
    }
}

- (WellbeingDataEntry*)wellbeingEntryForDate:(NSDateComponents*)dateComps {
    if (self.wellbeingDataArray) {
        for (WellbeingDataEntry* entry in self.wellbeingDataArray) {
            if ([ProfileDataManager isDateComponentsEqual:entry.entryDateComps toComps:dateComps]) {
                return entry;
            }
        }
    }
    return nil;
}

- (LifestyleDataEntry*)lifestyleEntryForDate:(NSDateComponents*)dateComps {
    if (self.lifestyleDataArray) {
        for (LifestyleDataEntry* entry in self.lifestyleDataArray) {
            if ([ProfileDataManager isDateComponentsEqual:entry.entryDateComps toComps:dateComps]) {
                return entry;
            }
        }
    }
    return nil;
}

- (PersonalDataEntry*)personalEntryForDate:(NSDateComponents*)dateComps {
    if (self.personalDataArray) {
        for (PersonalDataEntry* entry in self.personalDataArray) {
            if ([ProfileDataManager isDateComponentsEqual:entry.entryDateComps toComps:dateComps]) {
                return entry;
            }
        }
    }
    return nil;
}

- (void)setPersonalEntryIndetifier:(NSString*)string forIndex:(enum kPersonalEntryIndex)index {
    NSString* newStr = [NSString stringWithString:string];
    [self.personalEntryIdentifiers replaceObjectAtIndex:index withObject:newStr];
}

- (NSString*)personalEntryIdentifierForIndex:(enum kPersonalEntryIndex)index {
    return [self.personalEntryIdentifiers objectAtIndex:index];
}

- (WellbeingDataEntry*)wellbeingEntryForIndex:(NSInteger)index {
    return [self.wellbeingDataArray objectAtIndex:index];
}

- (LifestyleDataEntry*)lifestyleEntryForIndex:(NSInteger)index {
    return [self.lifestyleDataArray objectAtIndex:index];
}

- (PersonalDataEntry*)personalEntryForIndex:(NSInteger)index {
    return [self.personalDataArray objectAtIndex:index];
}

- (float)averageWellbeingAverageWithIndex:(enum kWellbeingEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date {
    int realDays = MIN(days, [self.wellbeingDataArray count]);
    float total = 0.0f;
    int count = [self.wellbeingDataArray count];
    for (int i = 0; i < realDays; i++) {
        int thisIndex = count - (i+1);
        WellbeingDataEntry* entry = [self wellbeingEntryForIndex:thisIndex];
        total += [[entry numberWithIndex:index] floatValue];
    }
    return total / realDays;
}

- (float)averageLifestyleAverageWithIndex:(enum kLifestyleEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date {
    int realDays = MIN(days, [self.lifestyleDataArray count]);
    float total = 0.0f;
    int count = [self.lifestyleDataArray count];
    for (int i = 0; i < realDays; i++) {
        int thisIndex = count - (i+1);
        LifestyleDataEntry* entry = [self lifestyleEntryForIndex:thisIndex];
        total += [[entry numberWithIndex:index] floatValue];
    }
    return total / realDays;
}

- (float)averagePersonalAverageWithIndex:(enum kPersonalEntryIndex)index forDays:(NSInteger)days fromDate:(NSDate*)date {
    int realDays = MIN(days, [self.personalDataArray count]);
    float total = 0.0f;
    int count = [self.personalDataArray count];
    for (int i = 0; i < realDays; i++) {
        int thisIndex = count - (i+1);
        PersonalDataEntry* entry = [self personalEntryForIndex:thisIndex];
        total += [[entry numberWithIndex:index] floatValue];
    }
    return total / realDays;
}

- (ResourceObject*)resourceObjectForIndex:(NSInteger)index {
    return [self.resourceArray objectAtIndex:index];
}

- (GoalEntry*)goalEntryForIndex:(NSInteger)index {
    return [self.goalArray objectAtIndex:index];
}

- (JournalEntry*)journalEntryForIndex:(NSInteger)index {
    return [self.journalArray objectAtIndex:index];
}

- (ChallengeObject*)challengeObjectForIndex:(NSInteger)index {
    return [self.challengeArray objectAtIndex:index];
}

- (NSInteger)resourceObjectCount {
    return [self.resourceArray count];
}

- (NSInteger)goalEntryCount {
    return [self.goalArray count];
}

- (NSInteger)journalEntryCount {
    return [self.journalArray count];
}

- (NSInteger)wellbeingEntryCount {
    return [self.wellbeingDataArray count];
}

- (NSInteger)personalEntryCount {
    return [self.personalDataArray count];
}

- (NSInteger)lifestyleEntryCount {
    return [self.lifestyleDataArray count];
}

- (NSInteger)challengeObjectCount {
    return [self.challengeArray count];
}

@end
