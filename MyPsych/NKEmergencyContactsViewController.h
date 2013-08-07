//
//  NKEmergencyContactsViewController.h
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface NKEmergencyContactsViewController : UITableViewController
<ABPeoplePickerNavigationControllerDelegate,
ABPersonViewControllerDelegate>

@end
