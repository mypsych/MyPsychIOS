//
//  NKTreatmentWebView.h
//  MyPsych
//
//  Created by kumar prince on 7/23/13.
//  Copyright (c) 2013 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKTreatmentWebView : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *myWebView;
}

@property (nonatomic,retain) UIWebView *myWebView;

@end
