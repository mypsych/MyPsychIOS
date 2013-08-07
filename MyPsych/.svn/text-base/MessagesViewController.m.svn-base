//
//  MessagesViewController.m
//  MyPsych
//
//  Created by J. Foster Lockwood on 10/21/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "MessagesViewController.h"
#import "ProfileDataManager.h"
#import "MessageEntryViewController.h"
#import "MessageCell.h"
#import "MessageDetailViewController.h"

@interface MessagesViewController ()

@property (strong) NSArray* messageArray;

@end

@implementation MessagesViewController

- (IBAction)composeButtonPressed:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MessageEntryViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"messageEntryViewController"];
    [controller setDoctorID:self.doctorID];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[ProfileDataManager sharedManager] loadMessagesFromDoctor:self.doctorID withBlock:^(NSArray *messages) {
        NSMutableArray* array = [NSMutableArray arrayWithArray:messages];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh-mm-ss"];
        [array sortUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
            NSString* date1str = [obj1 objectForKey:@"created"];
            NSString* date2str = [obj2 objectForKey:@"created"];
            return [[formatter dateFromString:date1str] compare:[formatter dateFromString:date2str]];
        }];
        self.messageArray = array;
        if ([self.messageArray count] > 0) {
            NSDictionary* messageID = [[self.messageArray objectAtIndex:0] objectForKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setObject:messageID
                                                      forKey:kStoredRecentMessage];
            [self.tableView reloadData];
        }
    }];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"messageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary* messageDict = [self.messageArray objectAtIndex:indexPath.row];
    [cell.fromLabel setText:[NSString stringWithFormat:@"%@:", [messageDict objectForKey:@"sender_name"]]];
    [cell.contentLabel setText:[messageDict objectForKey:@"message"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MessageDetailViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"messageDetailViewController"];
    NSDictionary* messageDict = [self.messageArray objectAtIndex:indexPath.row];
    [controller setMessageDict:messageDict];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
