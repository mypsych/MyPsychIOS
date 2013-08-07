//
//  NKSafetyPlansViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/24/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKSafetyPlansViewController.h"
#import "ProfileDataManager.h"
#import "NKSafetyPlanStep1ViewController.h"
#import "SafetyPlanHeader.h"

@interface NKSafetyPlansViewController () {
    NSArray *safetyPlans;
}

@end

@implementation NKSafetyPlansViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSafetyPlans];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewSafetyPlan)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Safety Plans";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadSafetyPlans];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NK Logic

- (void)addNewSafetyPlan {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"SafetyPlanStoryboard" bundle:nil];
    
    UINavigationController *navController = [storyboard instantiateInitialViewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
    
}

- (void)loadSafetyPlans {
    if ([[ProfileDataManager sharedManager] clientAccessKey]) {
        [[ProfileDataManager sharedManager] loadSafetyPlans:^(NSArray *list) {
            //NSMutableArray* array = [NSMutableArray arrayWithCapacity:[list count]];
            NSLog(@"Safety Plan List:%@", list);
            safetyPlans = list;
            [self.tableView reloadData];
        }];
    }
}

- (void)fetchSafetyPlanAtIndexPath:(NSIndexPath *)indexPath {
    SafetyPlanHeader *planHeader = [safetyPlans objectAtIndex:indexPath.row];
    
    if ([[ProfileDataManager sharedManager] clientAccessKey]) {
        [[ProfileDataManager sharedManager] fetchSafetyPlanWithHeader:planHeader withBlock:^(SafetyPlanEntry *planDetails) {
            NSLog(@"Safety Plan Details:%@", planDetails);
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"SafetyPlanStoryboard" bundle:nil];
            
            
            NKSafetyPlanStep1ViewController *step1VC = [storyboard instantiateViewControllerWithIdentifier:@"SafetyPlanStep1ViewController"];
            step1VC.safetyPlanDetails = planDetails;
            step1VC.isNewPlan = NO;
            NSLog(@"id:%@",planHeader.identifier);
            step1VC.recordIdentifier = planHeader.identifier;
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:step1VC];
            
            [self.navigationController presentViewController:navController animated:YES completion:nil];
            
            
        }];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return safetyPlans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    SafetyPlanHeader *currentSPHeader = [safetyPlans objectAtIndex:indexPath.row];
    if ([currentSPHeader.name isEqual:[NSNull null]]) {
        cell.textLabel.text = @"Web Plan";
    } else {
    cell.textLabel.text = currentSPHeader.name;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self fetchSafetyPlanAtIndexPath:indexPath];
}

@end
