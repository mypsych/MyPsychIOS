//
//  JournalListViewController.m
//  MyPsych
//
//  Created by James Lockwood on 6/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "JournalListViewController.h"
#import "JournalDetailViewController.h"
#import "ProfileDataManager.h"
#import "JournalEntry.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

@interface JournalListViewController ()

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller;

@end

@implementation JournalListViewController

- (IBAction)createNewJournalEntry:(id)sender {
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Journal Entry"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Text Entry", @"Video Entry", nil];
    [actionSheet showInView:self.view];
}

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    cameraUI.videoMaximumDuration = (60 * 5);
    cameraUI.videoQuality = UIImagePickerControllerQualityTypeLow;
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    
    [controller presentModalViewController:cameraUI animated:YES];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[ProfileDataManager sharedManager] journalEntryCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JournalEntry* entry = [[ProfileDataManager sharedManager] journalEntryForIndex:indexPath.row];
    NSString *CellIdentifier = nil;

    if ([entry.journalType integerValue] == kJournalEntryText) {
        CellIdentifier = @"journalTextCell";
    } else if ([entry.journalType integerValue] == kJournalEntryVideo) {
        CellIdentifier = @"journalVideoCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([entry.journalType integerValue] == kJournalEntryText) {
        cell.textLabel.text = entry.titleString;
        cell.detailTextLabel.text = [entry stringFromDate];
    } else if ([entry.journalType integerValue] == kJournalEntryVideo) {
        cell.textLabel.text = [entry stringFromDate];
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        JournalEntry* entry = [[ProfileDataManager sharedManager] journalEntryForIndex:indexPath.row];
        if ([entry.journalType integerValue] == kJournalEntryText) {
            // Do nothing since its just text
        } else {
            NSError* error = nil;
            NSURL* url = [NSURL URLWithString:entry.journalFilePath];
            [[NSFileManager defaultManager] removeItemAtPath:[url path] error:&error];
            if (error) {
                NSLog(@"Error deleting movie: %@", [error localizedDescription]);
            }
        }
        [[ProfileDataManager sharedManager] removeJournalEntry:entry];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }     
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    JournalEntry* newEntry = [[ProfileDataManager sharedManager] journalEntryForIndex:indexPath.row];
    if ([newEntry.journalType integerValue] == kJournalEntryText) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        JournalDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"journalDetailViewController"];
        [controller setJournalEntry:newEntry];
        [controller setIsNewJournalEntry:NO];
        [self presentModalViewController:controller animated:YES];
    } else if ([newEntry.journalType integerValue] == kJournalEntryVideo) {
        MPMoviePlayerViewController* controller = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:newEntry.journalFilePath]];
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
}

#pragma mark - Action Sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (buttonIndex == 0) {
        // Text
        JournalEntry* newEntry = [[JournalEntry alloc] init];
        newEntry.journalType = [NSNumber numberWithInteger:kJournalEntryText];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        JournalDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"journalDetailViewController"];
        [controller setJournalEntry:newEntry];
        [controller setIsNewJournalEntry:YES];
        [self presentModalViewController:controller animated:YES];
    } else if (buttonIndex == 1) {
        // Video
        if (![self startCameraControllerFromViewController:self]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Whoops"
                                                            message:@"Your device doesn't support video recording!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark - Camera Delegate

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [self dismissModalViewControllerAnimated: YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // Handle a movie capture
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        JournalEntry* newEntry = [[JournalEntry alloc] init];
        newEntry.journalType = [NSNumber numberWithInteger:kJournalEntryVideo];
        newEntry.journalFilePath = [[info objectForKey:
                                   UIImagePickerControllerMediaURL] absoluteString];
        newEntry.journalDate = [NSDate date];
        
        [[ProfileDataManager sharedManager] addJournalEntry:newEntry];
        [self.tableView reloadData];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
