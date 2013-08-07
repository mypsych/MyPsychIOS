//
//  WellbeingViewController.m
//  MyPsyche
//
//  Created by James Lockwood on 5/3/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "WellbeingViewController.h"
#import "MySlider.h"
#import "ProfileDataManager.h"
#import "WellbeingDataEntry.h"

@interface WellbeingViewController ()
@property (strong) NSMutableArray* sliderArray;
@end

@implementation WellbeingViewController
@synthesize sliderArray = _sliderArray;
@synthesize todaysEntry = _todaysEntry;

- (IBAction)sliderValueChanged:(id)sender {
    MySlider* slider = (MySlider*)sender;
    slider.valueChanged = YES;
    WellbeingDataEntry* entry = [[ProfileDataManager sharedManager] todaysWellbeingEntry];
    [entry setNumber:[NSNumber numberWithInt:(int)[slider value]] withIndex:slider.tag];
    [[ProfileDataManager sharedManager] setWellbeingGraphHidden:NO withIndex:slider.tag];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.todaysEntry) {
        for (UIView* view in self.view.subviews) {
            if ([view isKindOfClass:[MySlider class]]) {
                MySlider* slider = (MySlider*)view;
                NSNumber* value = [self.todaysEntry numberWithIndex:slider.tag];
                [slider setValue:[value intValue] animated:NO];
            }
        }
    }
}

- (void)setSliderPlacesAndLabels {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[MySlider class]]) {
            MySlider* slider = (MySlider*)view;
            CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI * 0.5);
            slider.transform = trans;
            
            if (slider.tag == kWellBeingEntryHoursSlept) {
                slider.remainsBlue = YES;
            }
            
            [slider.valueLabel setText:[NSString stringWithFormat:@"%i",(int)slider.value]];
            [slider.valueLabel setCenter:CGPointMake(slider.center.x - 10, slider.center.y)];
            [slider.nameLabel setCenter:CGPointMake(slider.center.x, slider.nameLabel.center.y)];
            [slider.nameButton setCenter:CGPointMake(slider.center.x, slider.nameLabel.center.y)];
            if (![[ProfileDataManager sharedManager] needsTodaysWellbeingEntry]) {
                slider.hasBeenTouched = YES;
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[MySlider class]]) {
            MySlider* slider = (MySlider*)view;
            if (CGRectContainsPoint(slider.nameLabel.frame, location)) {
                [self.tabBarController performSegueWithIdentifier:@"pushInfoController" sender:slider];
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cloth"]]];

    [self setSliderPlacesAndLabels];
    
    // Load data if previously set
    self.todaysEntry = [[ProfileDataManager sharedManager] todaysWellbeingEntry];
    if (!self.todaysEntry) {
        WellbeingDataEntry* entry = [[WellbeingDataEntry alloc] init];
        [[ProfileDataManager sharedManager] setTodaysWellbeingEntry:entry];
        [[ProfileDataManager sharedManager] addWellbeingEntry:entry];
        self.todaysEntry = entry;
    }    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Swipe Recognizer

- (IBAction)swipedOnAnalyzeView:(id)sender {
    
}

@end
