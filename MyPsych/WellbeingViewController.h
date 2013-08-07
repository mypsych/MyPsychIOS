//
//  WellbeingViewController.h
//  MyPsyche
//
//  Created by James Lockwood on 5/3/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WellbeingDataEntry;

@interface WellbeingViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak) WellbeingDataEntry* todaysEntry;

- (void)setSliderPlacesAndLabels;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)swipedOnAnalyzeView:(id)sender;

@end
