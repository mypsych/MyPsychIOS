//
//  MultipleChoiceViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 11/5/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "MultipleChoiceViewController.h"

@interface MultipleChoiceViewController ()

@property (strong) NSMutableArray* chosenStrings;

@end

@implementation MultipleChoiceViewController

- (IBAction)cancelButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(multipleChoiceControllerDidCancel:)]) {
        [self.delegate multipleChoiceControllerDidCancel:self];
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(multipleChoiceController:didSelectStrings:)]) {
        [self.delegate multipleChoiceController:self didSelectStrings:self.chosenStrings];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chosenStrings = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.stringArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"choiceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString* string = [self.stringArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:string];
    if ([self.chosenStrings containsObject:string]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* string = [self.stringArray objectAtIndex:indexPath.row];
    if ([self.chosenStrings containsObject:string]) {
        [self.chosenStrings removeObject:string];
    } else {
        [self.chosenStrings addObject:string];
    }
    [tableView reloadData];
}

@end
