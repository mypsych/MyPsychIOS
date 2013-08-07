//
//  PersonalViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/18/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "PersonalViewController.h"
#import "MySlider.h"
#import "ProfileDataManager.h"
#import "PersonalDataEntry.h"
#import "PersonalTitleEditViewController.h"

@interface PersonalViewController ()
@property (strong) NSMutableArray* sliderArray;
@end

@implementation PersonalViewController
@synthesize sliderArray = _sliderArray;
@synthesize todaysEntry = _todaysEntry;

- (IBAction)sliderValueChanged:(id)sender {
    MySlider* slider = (MySlider*)sender;
    slider.valueChanged = YES;
    PersonalDataEntry* entry = [[ProfileDataManager sharedManager] todaysPersonalEntry];
    [entry setNumber:[NSNumber numberWithInt:(int)[slider value]] withIndex:slider.tag];
    [[ProfileDataManager sharedManager] setPersonalGraphHidden:NO withIndex:slider.tag];
}

- (IBAction)nameButtonPressed:(UIButton*)button {
    [self modalEditWithIndex:button.tag];
}

- (void)modalEditWithIndex:(int)index {
    [self performSegueWithIdentifier:@"modalTitleEdit" sender:self];
    PersonalTitleEditViewController* controller = (PersonalTitleEditViewController*)self.presentedViewController;
    [controller setPersonalIndex:index];
    [controller.titleField setText:[[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:index]];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[MySlider class]]) {
            MySlider* slider = (MySlider*)view;
            [slider.nameLabel setText:[[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:slider.tag]];
        }
    }
}

- (void)setSliderPlacesAndLabels {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[MySlider class]]) {
            MySlider* slider = (MySlider*)view;
            CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI * 0.5f);
            slider.transform = trans;
            
            [slider.valueLabel setText:[NSString stringWithFormat:@"%i",(int)slider.value]];
            [slider.valueLabel setCenter:CGPointMake(slider.center.x - 10, slider.center.y)];
            [slider.nameLabel setText:[[ProfileDataManager sharedManager] personalEntryIdentifierForIndex:slider.tag]];
            [slider.nameLabel setCenter:CGPointMake(slider.center.x, slider.nameLabel.center.y)];
            [slider.nameButton setCenter:CGPointMake(slider.center.x, slider.nameLabel.center.y)];
            if (![[ProfileDataManager sharedManager] needsTodaysPersonalEntry]) {
                slider.hasBeenTouched = YES;
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
    self.todaysEntry = [[ProfileDataManager sharedManager] todaysPersonalEntry];
    if (!self.todaysEntry) {
        PersonalDataEntry* entry = [[PersonalDataEntry alloc] init];
        [[ProfileDataManager sharedManager] setTodaysPersonalEntry:entry];
        [[ProfileDataManager sharedManager] addPersonalEntry:entry];
        self.todaysEntry = entry;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
