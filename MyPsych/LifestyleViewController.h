//
//  LifestyleViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LifestyleDataEntry;

@interface LifestyleViewController : UIViewController

@property (weak) LifestyleDataEntry* todaysEntry;

- (void)setSliderPlacesAndLabels;

- (IBAction)sliderValueChanged:(id)sender;

@end
