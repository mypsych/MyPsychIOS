//
//  FeelingInfoViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/20/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDataManager.h"

extern NSString* const kWellbeingBriefInfoText[WELLBEING_MINIMUM_COUNT];
extern NSString* const kLifestyleBriefInfoText[LIFESTYLE_MINIMUM_COUNT];

extern NSString* const kWellbeingSpecificLowInfoText[WELLBEING_MINIMUM_COUNT];
extern NSString* const kLifestyleSpecificLowInfoText[LIFESTYLE_MINIMUM_COUNT];

extern NSString* const kWellbeingSpecificMidInfoText[WELLBEING_MINIMUM_COUNT];
extern NSString* const kLifestyleSpecificMidInfoText[LIFESTYLE_MINIMUM_COUNT];

extern NSString* const kWellbeingSpecificHighInfoText[WELLBEING_MINIMUM_COUNT];
extern NSString* const kLifestyleSpecificHighInfoText[LIFESTYLE_MINIMUM_COUNT];

@interface FeelingInfoViewController : UIViewController

@property (strong) NSString* infoText;
@property (strong) IBOutlet UITextView* infoTextView;

@end
