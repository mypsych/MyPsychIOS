//
//  DoctorListViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "DoctorListViewController.h"
#import "ProfileDataManager.h"
#import "MessagesViewController.h"

@interface DoctorListViewController ()

@property (strong) NSArray* doctorArray;

@end

@implementation DoctorListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[ProfileDataManager sharedManager] clientAccessKey]) {
        [[ProfileDataManager sharedManager] loadDoctors:^(NSArray *doctors) {
            self.doctorArray = doctors;
            [self.tableView reloadData];
        }];
    }
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
    return [self.doctorArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"doctorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary* doctor = [self.doctorArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[doctor objectForKey:@"name"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MessagesViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"messagesViewController"];
    NSDictionary* doctor = [self.doctorArray objectAtIndex:indexPath.row];
    [controller setDoctorID:[doctor objectForKey:@"id"]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
