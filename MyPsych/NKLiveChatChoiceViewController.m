//
//  NKLiveChatChoiceViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKLiveChatChoiceViewController.h"


@interface NKLiveChatChoiceViewController ()

@end

@implementation NKLiveChatChoiceViewController
@synthesize myLiveChatWebView;


- (id)initWithStyle:(UITableViewStyle)style
{
            self    = [super initWithStyle:style];
    if (self) {
        // Custom initialization
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title      =  @"Life Line";
    
    NKSupport       = [[NSMutableArray alloc]initWithObjects:@"1 (800) 273-8255",@"Live Chat", nil];
   

    NKSubtitle      = [[NSMutableArray alloc]initWithObjects:@"National Suicide Prevention   Hotline",@"Lifeline           crisis chat", nil];

    NKSubtitle = [[NSMutableArray alloc]initWithObjects:@"National Suicide Prevention Hotline",@"Lifeline crisis chat", nil];

    
    UIImage *Call = [UIImage imageNamed:@"call.png"];
    UIImage *chat = [UIImage imageNamed:@"chat.png"];
    NKImages      = [[NSMutableArray alloc]initWithObjects: Call, chat ,nil];
    
    
    
    

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [NKSupport count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell  *cell          = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
                            cell    = [[UITableViewCell alloc] initWithStyle:                                                       UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
   
    
    
    // Configure the cell...
    
    cell.textLabel.text       = [NKSupport objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [ NKSubtitle objectAtIndex:indexPath.row];
    cell.imageView.image      = [NKImages  objectAtIndex:indexPath.row];
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSURLRequest *myRequest   = nil;
        NKTreatmentWebView *temp  = [[NKTreatmentWebView alloc] initWithNibName:
                                        @"NKTreatmentWebView" bundle:[NSBundle mainBundle]];
        self.myLiveChatWebView    = temp;
    
    if([[NKSupport objectAtIndex:indexPath.row ] isEqualToString :@"1 (800) 273-8255" ])
    {
                    NSURL *myUrl  = [ NSURL URLWithString:@"tel://18002738255"];
                    myRequest     = [ NSURLRequest requestWithURL:myUrl];
            
            [self.myLiveChatWebView.myWebView loadRequest:myRequest];
    }
    
    else
    {
                    NSURL *myUrl  = [ NSURL URLWithString:@"http://www.suicidepreventionlifeline.org/GetHelp/LifelineChat.aspx"];
                        myRequest = [ NSURLRequest requestWithURL:myUrl];
        
    }
    
    [self.navigationController pushViewController:self.myLiveChatWebView animated:YES];
    [self.myLiveChatWebView.myWebView loadRequest:myRequest];
    

}
       


@end
