//
//  ResourcesTableViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/20/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ResourcesTableViewController.h"
#import "ProfileDataManager.h"
#import "ResourceObject.h"

@interface ResourcesTableViewController ()

@end

@implementation ResourcesTableViewController

- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"resourceMakeModal" sender:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ProfileDataManager sharedManager] resourceObjectCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"urlCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    ResourceObject* object = [[ProfileDataManager sharedManager] resourceObjectForIndex:indexPath.row];
    cell.textLabel.text = object.resourceTitle;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 3) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row > 3) { // Not our first three!
            ResourceObject* object = [[ProfileDataManager sharedManager] resourceObjectForIndex:indexPath.row];
            [[ProfileDataManager sharedManager] removeResourceObject:object];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResourceObject* object = [[ProfileDataManager sharedManager]
                              resourceObjectForIndex:indexPath.row];
    [[ProfileDataManager sharedManager] saveDataToDisk];
    NSString* urlString = object.resourceURL;
    if ([urlString isEqualToString:@"http://www.my-psych.com"]) {
        urlString = @"http://www.MyPsychTES.com";
    }
    if (![urlString hasPrefix:@"http://"]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
