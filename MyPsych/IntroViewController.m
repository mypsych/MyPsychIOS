//
//  IntroViewController.m
//  MyPsych
//
//  Created by Foster Lockwood on 12/26/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "IntroViewController.h"
#import "ViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (IBAction)startButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //[self.mainController performSegueWithIdentifier:@"pushAccountController" sender:nil];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
