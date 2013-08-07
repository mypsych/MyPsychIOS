//
//  FormListViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "FormListViewController.h"
#import "ProfileDataManager.h"
#import "FormEntryViewController.h"

@interface FormListViewController ()

@property (strong) NSArray* formArray;

@end

@implementation FormListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[ProfileDataManager sharedManager] clientAccessKey]) {
        [[ProfileDataManager sharedManager] loadForms:^(NSArray *forms) {
            NSLog(@"Forms: %@", forms);
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:[forms count]];
            for (NSDictionary* form in forms) {
                if (![[form objectForKey:@"completed"] boolValue]) {
                    [array addObject:form];
                }
            }
            self.formArray = array;
            [self.tableView reloadData];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.formArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"formCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary* form = [self.formArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [form objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    NSString* formID = [[self.formArray objectAtIndex:indexPath.row] objectForKey:@"form_id"];
    NSString* thatformID = [[self.formArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    [[ProfileDataManager sharedManager] loadFormWithID:formID withBlock:^(NSDictionary *form) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        FormEntryViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"formEntryViewController"];
        [controller setEntryForm:form];
        [controller setFormID:thatformID];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

@end
