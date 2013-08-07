//
//  FormEntryViewController.h
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipleChoiceViewController.h"

@interface FormEntryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, MultipleChoiceViewControllerDelegate>

@property (strong) NSDictionary* entryForm;
@property (strong) NSString* formID;
@property (weak) IBOutlet UITableView* tableView;
@property (weak) IBOutlet UIPickerView* pickerView;
@property (strong) IBOutlet UIBarButtonItem* submitButton;
@property (strong) UIBarButtonItem* doneButton;

- (IBAction)submitButtonPressed:(UIBarButtonItem*)sender;
- (void)doneButtonPressed:(UIBarButtonItem*)sender;

@end
