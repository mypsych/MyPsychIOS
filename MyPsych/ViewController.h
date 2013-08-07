//
//  ViewController.h
//  MyPsyche
//
//  Created by James Lockwood on 5/1/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoalScrollerView, NotificationView;

extern NSString* const kLastOpenedDateIdentifierKey;
extern NSString* const kLastQuoteDateIdentifierKey;

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (strong) IBOutlet GoalScrollerView* goalMarqueeView;
@property (strong) IBOutlet UIButton        * dataEntryButton;
@property (strong) IBOutlet UINavigationItem* navItem;
@property (strong) IBOutlet UIBarButtonItem * quoteButton;
@property (strong) IBOutlet UIProgressView  * levelProgressView;
@property (strong) IBOutlet UILabel         * pointCountLabel;
@property (strong) IBOutlet UIScrollView    * iconScrollView;
@property (strong) IBOutlet UIPageControl   * pageControl;

@property (weak) IBOutlet NotificationView  * formNotification;
@property (weak) IBOutlet NotificationView  * dialogueNotification;

- (IBAction)goalButtonPressed:(UIButton*)sender;
- (IBAction)liveChatButtonPressed:(UIButton*)sender;
- (IBAction)treatmentLocatorButtonPressed:(UIButton*)sender;
- (IBAction)emergencyContactsButtonPressed:(UIButton*)sender;
- (IBAction)safetyPlansButtonPressed:(UIButton*)sender;
- (void)quoteButtonPressed;

@end
