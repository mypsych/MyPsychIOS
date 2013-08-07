//
//  FormEntryViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "FormEntryViewController.h"
#import "ProfileDataManager.h"

@interface FormEntryViewController ()

@property (strong) NSArray* formQuestions;
@property (strong) NSMutableDictionary* formAnswers;
@property (strong) NSDictionary* currentSelectedElement;

@end

@implementation FormEntryViewController

- (IBAction)submitButtonPressed:(id)sender {
    [sender setEnabled:NO];
    NSMutableArray* array = [NSMutableArray array];
    for (NSString* question in [self.formAnswers allKeys]) {
        NSString* answer = [self.formAnswers objectForKey:question];
        if (!answer) {
            answer = @"";
        }
        [array insertObject:@{ @"question_id" : question, @"value" : answer } atIndex:0];
    }
    
    [[ProfileDataManager sharedManager] sendForm:@{@"id" : self.formID, @"answers" : array} withBlock:^{
        // Sent!
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)doneButtonPressed:(UIBarButtonItem*)sender {
    [self.pickerView setHidden:YES];
    if (self.currentSelectedElement) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        NSString* answer = [[self.currentSelectedElement objectForKey:@"options"] objectAtIndex:row];
        [self.formAnswers setObject:answer forKey:[self.currentSelectedElement objectForKey:@"id"]];
        [self.tableView reloadData];
    }
    self.currentSelectedElement = nil;
    self.navigationItem.rightBarButtonItem = self.submitButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.formAnswers = [NSMutableDictionary dictionary];
    self.currentSelectedElement = nil;
    [self.pickerView setHidden:YES];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.pickerView.frame.size.height, 0)];
    
    self.formQuestions = [self.entryForm objectForKey:@"questions"];
    self.title = [self.entryForm objectForKey:@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.formQuestions count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.formQuestions objectAtIndex:section] objectForKey:@"label"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"formCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString* questionID = [[self.formQuestions objectAtIndex:indexPath.section] objectForKey:@"id"];
    if ([self.formAnswers objectForKey:questionID]) {
        [cell.textLabel setText:[self.formAnswers objectForKey:questionID]];
    } else {
        [cell.textLabel setText:@"Tap to answer..."];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pickerView setHidden:YES];
    self.currentSelectedElement = nil;
    self.navigationItem.rightBarButtonItem = self.submitButton;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* element = [self.formQuestions objectAtIndex:indexPath.section];
    self.currentSelectedElement = element;
    [self.pickerView setHidden:YES];
    
    if ([[element objectForKey:@"type"] isEqualToString:@"select"] ||
        [[element objectForKey:@"type"] isEqualToString:@"radio"]) {
        UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = done;
        [self.pickerView setHidden:NO];
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.pickerView.frame.size.height, 0)];
        [self.pickerView reloadAllComponents];
    } else if ([[element objectForKey:@"type"] isEqualToString:@"check"]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MultipleChoiceViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"multipleChoiceViewController"];
        [controller setDelegate:self];
        [controller setStringArray:[self.currentSelectedElement objectForKey:@"options"]];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[element objectForKey:@"label"]
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert show];
    }
}

#pragma mark - Multiple Choice Delegate

- (void)multipleChoiceControllerDidCancel:(MultipleChoiceViewController *)controller {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)multipleChoiceController:(MultipleChoiceViewController *)controller didSelectStrings:(NSArray *)stringArray {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    NSString* answer = @"";
    for (NSString* string in stringArray) {
        answer = [answer stringByAppendingFormat:@"%@ ", string];
    }
    if ([stringArray count] == 0) {
        answer = @"None";
    }
    [self.formAnswers setObject:answer forKey:[self.currentSelectedElement objectForKey:@"id"]];
    [self.tableView reloadData];
}

#pragma mark - Alert Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.currentSelectedElement) {
        if (buttonIndex == 1) {
            NSString* answer = [[alertView textFieldAtIndex:0] text];
            [self.formAnswers setObject:answer forKey:[self.currentSelectedElement objectForKey:@"id"]];
            [self.tableView reloadData];
            self.currentSelectedElement = nil;
        }
    } else {
        // Ignore (Cancelled)
    }
}

#pragma mark - Picker Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.currentSelectedElement) {
        return [[self.currentSelectedElement objectForKey:@"options"] count];
    } else {
        return 0;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.currentSelectedElement) {
        return [[self.currentSelectedElement objectForKey:@"options"] objectAtIndex:row];
    } else {
        return @"";
    }
}

#pragma mark - Picker Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.currentSelectedElement) {
        NSString* answer = [[self.currentSelectedElement objectForKey:@"options"] objectAtIndex:row];
        [self.formAnswers setObject:answer forKey:[self.currentSelectedElement objectForKey:@"id"]];
        [self.tableView reloadData];
    }
}

@end
