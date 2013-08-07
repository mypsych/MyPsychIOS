//
//  NKEmergencyContactsViewController.m
//  MyPsych
//
//  Created by Ryan Nam on 7/21/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKEmergencyContactsViewController.h"
#import <AddressBookUI/AddressBookUI.h>

#define NKEmergencyContactListKey @"emergencyContacts"
#define NKPersonNameKey           @"name"
#define NKPersonPicKey            @"profilePic"

@interface NKEmergencyContactsViewController () {
    BOOL isAddingPlayer;
    NSArray *contactList;
}

@end

@implementation NKEmergencyContactsViewController

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
    [self getContacts];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title     =  @"Emergency Contacts";
    isAddingPlayer = NO;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewContact)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    isAddingPlayer = NO;
    [self getContacts];
    [self.tableView reloadData];
}

#pragma mark - NK Logic

- (void) getContacts {
    
    contactList = [[NSUserDefaults standardUserDefaults] objectForKey:NKEmergencyContactListKey];
    NSLog(@"contact list:%@", contactList);

}

- (void) addNewContact {
    
    isAddingPlayer = YES;
    
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// Show the picker
	[self presentModalViewController:picker animated:YES];
    
    
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
    NSLog(@"contact list count:%i", contactList.count);
    return contactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *currentContact = [contactList objectAtIndex:indexPath.row];
    UIImage *pic = [UIImage imageWithData:[currentContact objectForKey:NKPersonPicKey]];
    
    cell.textLabel.text  = [currentContact objectForKey:NKPersonNameKey];
    cell.imageView.image = pic;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *editList = [NSMutableArray arrayWithArray:contactList];
    [editList removeObjectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:editList] forKey:NKEmergencyContactListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self getContacts];
    [self.tableView reloadData];
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
    
    NSDictionary *selectedContact = [contactList objectAtIndex:indexPath.row];
    NSString *fullName = [selectedContact objectForKey:NKPersonNameKey];
    
	// Fetch the address book
	ABAddressBookRef addressBook = ABAddressBookCreate();
	// Search for the person named "Appleseed" in the address book
	NSArray *people = (__bridge NSArray *)ABAddressBookCopyPeopleWithName(addressBook, (__bridge CFStringRef)fullName);
	// Display "Appleseed" information if found in the address book
	if ((people != nil) && [people count])
        {
		ABRecordRef person = (__bridge ABRecordRef)[people objectAtIndex:0];
		ABPersonViewController *picker = [[ABPersonViewController alloc] init];
		picker.personViewDelegate = self;
		picker.displayedPerson = person;
		// Allow users to edit the person’s information
		picker.allowsEditing = YES;
		[self.navigationController pushViewController:picker animated:YES];
        }
	else
        {
		// Show an alert if "Appleseed" is not in Contacts
        
        NSString *errorMessage = [NSString stringWithFormat:@"Could not find %@ in your contacts.", fullName];
        
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:nil];
		[alert show];
        }
	
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *fullName;
    if (firstName.length == 0) {
        fullName = [NSString stringWithFormat:@"%@", lastName];
        
    } else if (lastName.length == 0) {
        fullName = [NSString stringWithFormat:@"%@", firstName];
        
    } else {
        fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        
    }
    
    
    NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(person);
    
    if (imgData == nil) {
        imgData = UIImagePNGRepresentation([UIImage imageNamed:@"userDefault.png"]);
    }
    
    NSLog(@"Contact List before update:%@", contactList);
    
    
    // create player
    NSDictionary *contact = [[NSDictionary alloc] initWithObjects:@[fullName, imgData] forKeys:@[NKPersonNameKey, NKPersonPicKey]];
    
    NSMutableArray *editList = [NSMutableArray arrayWithArray:contactList];
        [editList addObject:contact];

    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:editList] forKey:NKEmergencyContactListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Contact List after update:%@", editList);

    
    [self dismissModalViewControllerAnimated:YES];
    
	return NO;
}


// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
	return YES;
}


// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person
					property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	return YES;
}


@end
