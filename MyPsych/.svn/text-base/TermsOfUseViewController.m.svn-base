//
//  TermsOfUseViewController.m
//  MyPsych
//
//  Created by Foster Lockwood on 4/8/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "TermsOfUseViewController.h"

@interface TermsOfUseViewController ()

@end

@implementation TermsOfUseViewController

- (IBAction)acceptButtonPressed:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"tou" ofType:@"txt"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSString* termsString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    self.textView.text = termsString;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
