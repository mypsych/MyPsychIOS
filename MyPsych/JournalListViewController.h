//
//  JournalListViewController.h
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalListViewController : UITableViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)createNewJournalEntry:(id)sender;

@end
