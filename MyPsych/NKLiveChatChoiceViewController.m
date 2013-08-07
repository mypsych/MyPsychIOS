//
//  NKLiveChatChoiceViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKLiveChatChoiceViewController.h"

@interface NKLiveChatChoiceViewController () {
    NSArray *dataSource;
    
    NSString *titleKey;
    NSString *subtitleKey;
    NSString *imgNameKey;
    NSString *urlKey;
    
    UIColor *myPsychBlue;
}

@end

@implementation NKLiveChatChoiceViewController
@synthesize myLiveChatWebView = _myLiveChatWebView;


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
    
    self.title  = @"Life Line";
    titleKey    = @"title";
    subtitleKey = @"subtitle";
    imgNameKey  = @"imgName";
    urlKey      = @"url";
    
    myPsychBlue = [UIColor colorWithRed:46.0/255.0
                                  green:96.0/255.0
                                   blue:255.0/255.0
                                  alpha:.9];
    
    NSArray *keys = @[titleKey, subtitleKey, imgNameKey, urlKey];
    
    NSDictionary *row1 = [[NSDictionary alloc] initWithObjects:@[@"1 (800) 273-8255",
                                                                 @"National Suicide Prevention Hotline",
                                                                 @"call.png",
                                                                 @"tel://18002738255"]
                                                       forKeys:keys];
    
    NSDictionary *row2 = [[NSDictionary alloc] initWithObjects:@[@"Live Chat",
                                                                 @"Lifeline crisis chat",
                                                                 @"chat.png",
                                                                 @"http://www.suicidepreventionlifeline.org/GetHelp/LifelineChat.aspx"]
                                                       forKeys:keys];

    NSArray *section1 = @[row1, row2];
    dataSource        = @[section1];
    

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
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *currentSection = [dataSource objectAtIndex:section];
    return currentSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    NSArray *currentSection  = [dataSource objectAtIndex:indexPath.section];
    NSDictionary *currentRow = [currentSection objectAtIndex:indexPath.row];
    
    cell.textLabel.text       = [currentRow objectForKey:titleKey];
    cell.detailTextLabel.text = [currentRow objectForKey:subtitleKey];
    cell.imageView.image      = [UIImage imageNamed:[currentRow objectForKey:imgNameKey]];
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;

    
    cell.detailTextLabel.textColor = myPsychBlue;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURLRequest *myRequest;
    NSURL *myUrl;
    _myLiveChatWebView = [[NKTreatmentWebView alloc] initWithNibName:@"NKTreatmentWebView"
                                                              bundle:[NSBundle mainBundle]];
    
    NSArray *currentSection  = [dataSource objectAtIndex:indexPath.section];
    NSDictionary *currentRow = [currentSection objectAtIndex:indexPath.row];
    
    myUrl     = [NSURL URLWithString:[currentRow objectForKey:urlKey]];
    myRequest = [NSURLRequest requestWithURL:myUrl];
    
    [self.navigationController pushViewController:self.myLiveChatWebView animated:YES];
    [_myLiveChatWebView.myWebView loadRequest:myRequest];

}
       


@end
