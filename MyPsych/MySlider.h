//
//  MySlider.h
//  MyPsyche
//
//  Created by James Lockwood on 5/3/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySlider : UISlider

@property (assign) BOOL valueChanged;
@property (strong) IBOutlet UILabel* valueLabel;
@property (strong) IBOutlet UILabel* nameLabel;
@property (strong) IBOutlet UIButton* nameButton; // Optional, for personal entries only
@property (assign) BOOL hasBeenTouched;
@property (assign) BOOL remainsBlue;

@end
