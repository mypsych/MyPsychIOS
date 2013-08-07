//
//  PersonalViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/18/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalDataEntry;

@interface PersonalViewController : UIViewController

@property (weak) PersonalDataEntry* todaysEntry;

- (void)setSliderPlacesAndLabels;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)nameButtonPressed:(UIButton*)button;

- (void)modalEditWithIndex:(int)index;

@end
