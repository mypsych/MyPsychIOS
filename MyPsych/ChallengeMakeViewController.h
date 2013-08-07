//
//  ChallengeMakeViewController.h
//  MyPsych
//
//  Created by James Lockwood on 6/12/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeMakeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong) IBOutlet UISegmentedControl* typeSelector;
@property (strong) IBOutlet UIPickerView* categoryPickerView;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)typeSelectorChanged:(id)sender;

@end
