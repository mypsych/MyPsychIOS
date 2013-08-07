//
//  NKTreatmentChoiceViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKTreatmentChoiceViewController.h"

@interface NKTreatmentChoiceViewController ()
{
    NSString *sectionName;
}

@end

@implementation NKTreatmentChoiceViewController
@synthesize myTreatmentWebView;



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
    
    self.title =  @"Find Help";
    
    NKSamhsa   = [[NSMutableArray alloc]initWithObjects:@"Substance Abuse Locator",@"Mental Health Locator", nil];
    
    NKOther    = [[NSMutableArray alloc]initWithObjects:@"Psychology Today",@"Suicide Prevention Lifeline Locator", nil];
    

    
    [UIImage imageNamed:@"location.png"];
    [super viewDidLoad];
    
   

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#
    // Return the number of rows in the section.
    return [NKSamhsa count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
                                cell= [[UITableViewCell alloc]
                                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        cell.textLabel.text    = [NKSamhsa objectAtIndex:indexPath.row];
    }
  else {
        cell.textLabel.text    = [NKOther objectAtIndex:indexPath.row];
    }
    
        cell.accessoryType     = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image   = [UIImage imageNamed:@"location.png"];
    
        return cell;

}
    
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURLRequest *myRequest   = nil;
    NKTreatmentWebView *temp  = [[NKTreatmentWebView alloc] initWithNibName:

                                @"NKTreatmentWebView" bundle:[NSBundle mainBundle]];
    self.myTreatmentWebView   = temp;
        
    if(indexPath.section ==0)
    {
        if([[NKSamhsa objectAtIndex:indexPath.row ] isEqualToString :@"Substance Abuse Locator" ])
        {
            NSURL *myUrl    = [ NSURL URLWithString:@"http://findtreatment.samhsa.gov/TreatmentLocator/faces/quickSearch.jspx"];
            myRequest       = [ NSURLRequest requestWithURL:myUrl];
        }
    
    else if([[NKSamhsa objectAtIndex:indexPath.row ] isEqualToString :@"Mental Health Locator" ])
        {
            NSURL *myUrl    = [ NSURL URLWithString:@"http://findtreatment.samhsa.gov/MHTreatmentLocator/faces/quickSearch.jspx"];
            myRequest       = [ NSURLRequest requestWithURL:myUrl];
        }
    }
    
    else if([[NKOther objectAtIndex:indexPath.row] isEqualToString :@"Suicide Prevention Lifeline Locator"])
    {
            NSURL *myUrl    = [ NSURL URLWithString:@"http://www.suicidepreventionlifeline.org/GetInvolved/Locator"];
            myRequest       = [ NSURLRequest requestWithURL:myUrl];
    }

    else if([[NKOther objectAtIndex:indexPath.row] isEqualToString :@"Psychology Today"])
    {
            NSURL *myUrl    = [ NSURL URLWithString:@"http://m.therapists.psychologytoday.com/rms/prof_search.php"];
            myRequest       = [ NSURLRequest requestWithURL:myUrl];
        
    }

        [self.navigationController pushViewController:self.myTreatmentWebView animated:YES];
        [self.myTreatmentWebView.myWebView loadRequest:myRequest];
}
                                                
        



 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section)
    {
        case 0:
            sectionName = @"SAMHSA ";
            break;
        case 1:
            sectionName = @"OTHER";
            break;
            // ...
    }
    return sectionName;
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
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}


@end
