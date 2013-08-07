//
//  LifestyleGraphViewController.h
//  MyPsych
//
//  Created by James Lockwood on 5/13/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface LifestyleGraphViewController : UIViewController <CPTScatterPlotDelegate, CPTScatterPlotDataSource, CPTPlotSpaceDelegate>

@property (strong) IBOutlet CPTGraphHostingView* graphContainerView;

- (IBAction)legendButtonPressed:(id)sender;

- (void)moveToTodaysDate;

@end
