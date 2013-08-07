//
//  NKTreatmentWebView.m
//  MyPsych
//
//  Created by kumar prince on 7/23/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import "NKTreatmentWebView.h"

@interface NKTreatmentWebView ()

@end

@implementation NKTreatmentWebView
@synthesize myWebView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = myWebView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    myWebView.scrollView.minimumZoomScale = rw;
    myWebView.scrollView.maximumZoomScale = rw;
    myWebView.scrollView.zoomScale = rw;
    myWebView.scalesPageToFit= YES;
    
}
@end
