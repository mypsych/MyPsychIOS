//
//  MultipleChoiceViewController.h
//  MyPsych
//
//  Created by J. Foster Lockwood on 11/5/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultipleChoiceViewController;

@protocol MultipleChoiceViewControllerDelegate <NSObject>

- (void)multipleChoiceControllerDidCancel:(MultipleChoiceViewController*)controller;
- (void)multipleChoiceController:(MultipleChoiceViewController*)controller didSelectStrings:(NSArray*)stringArray;

@end

@interface MultipleChoiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak) id <MultipleChoiceViewControllerDelegate> delegate;
@property (strong) NSArray* stringArray;
@property (weak) IBOutlet UITableView* tableView;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
