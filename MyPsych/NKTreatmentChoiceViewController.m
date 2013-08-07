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
    NSArray *dataSource;
    
    NSString *sectionName;
    NSString *titleKey;
    NSString *imgNameKey;
    NSString *urlKey;
}

@end

@implementation NKTreatmentChoiceViewController
@synthesize myTreatmentWebView = _myTreatmentWebView;


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
    
    titleKey    = @"title";
    imgNameKey  = @"imgName";
    urlKey      = @"url";
    
    NSArray *keys = @[titleKey, imgNameKey, urlKey];
    
    NSDictionary *row1 = [[NSDictionary alloc] initWithObjects:@[@"Substance Abuse Locator",
                                                                @"location.png",
                                                                @"http://findtreatment.samhsa.gov/TreatmentLocator/faces/quickSearch.jspx"]
                                                       forKeys:keys];
    
    NSDictionary *row2 = [[NSDictionary alloc] initWithObjects:@[@"Mental Health Locator",
                                                                @"location.png",
                                                                @"http://findtreatment.samhsa.gov/MHTreatmentLocator/faces/quickSearch.jspx"]
                                                       forKeys:keys];
    
    NSDictionary *row3 = [[NSDictionary alloc] initWithObjects:@[@"Psychology Today",
                                                                @"location.png",
                                                                @"http://m.therapists.psychologytoday.com/rms/prof_search.php"]
                                                       forKeys:keys];
    NSDictionary *row4 = [[NSDictionary alloc] initWithObjects:@[@"Suicide Prevention Lifeline",
                                                                @"location.png",
                                                                @"http://www.suicidepreventionlifeline.org/GetInvolved/Locator"]
                                                       forKeys:keys];
    
    NSArray *section1 = @[row1, row2];
    NSArray *section2 = @[row3, row4];
    dataSource        = @[section1, section2];
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    NSArray *currentsection = [dataSource objectAtIndex:section];
    return currentsection.count;
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
    
        cell.textLabel.text  = [currentRow objectForKey:titleKey];
        cell.imageView.image = [UIImage imageNamed:[currentRow objectForKey:imgNameKey]];
        cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
    
        return cell;

}
    
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURLRequest *myRequest;
    NSURL *myUrl;
    _myTreatmentWebView = [[NKTreatmentWebView alloc] initWithNibName:@"NKTreatmentWebView"
                                                               bundle:[NSBundle mainBundle]];
    
    NSArray *currentSection  = [dataSource objectAtIndex:indexPath.section];
    NSDictionary *currentRow = [currentSection objectAtIndex:indexPath.row];
    
    myUrl     = [NSURL URLWithString:[currentRow objectForKey:urlKey]];
    myRequest = [NSURLRequest requestWithURL:myUrl];
   
    [self.navigationController pushViewController:_myTreatmentWebView animated:YES];
    [_myTreatmentWebView.myWebView loadRequest:myRequest];
}
                                                

 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section)
    {
        case 0:
            sectionName = @"SAMHSA ";
            break;
        case 1:
            sectionName = @"Other";
            break;
            // ...
    }
    return sectionName;
}


@end
