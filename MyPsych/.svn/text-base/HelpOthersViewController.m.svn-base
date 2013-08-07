//
//  HelpOthersViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "HelpOthersViewController.h"
#import "ProfileDataManager.h"

@interface HelpOthersViewController ()

@end

@implementation HelpOthersViewController
@synthesize progressBar = _progressBar;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Mail Composer Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    /*
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    */
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) { // Only in the second section
        if (indexPath.row == 0) {
            // Rate this app
            [[ProfileDataManager sharedManager] addPsychPoints:1];
            NSString* url = [NSString stringWithFormat:  @"http://itunes.com/apps/mypsych"];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url ]];
        } else if (indexPath.row == 1) {
            // Contact us
            
            if ([MFMailComposeViewController canSendMail])
            {
                [[ProfileDataManager sharedManager] addPsychPoints:1];
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                [mailer setSubject:@"MyPsych Support"];
                NSArray *toRecipients = [NSArray arrayWithObjects:@"mypsychteam@gmail.com", nil];
                [mailer setToRecipients:toRecipients];
                NSString *emailBody = @"";
                [mailer setMessageBody:emailBody isHTML:NO];
                [self presentModalViewController:mailer animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Your device doesn't support the composer sheet"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
        } else if (indexPath.row == 5) {
            // Set PIN #
            [self performSegueWithIdentifier:@"pushPINController" sender:self];
        }
    }
}

@end
