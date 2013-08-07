//
//  AppDelegate.h
//  MyPsych
//
//  Created by James Lockwood on 5/8/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const kHasShownAccountInfoKey;
extern NSString* const kHasShownIntroScreenKey;
extern NSString* const kUDIDStoreKey;
extern NSString* const kClientPINStoreKey;
extern NSString* const kClientIDStoreKey;
extern NSString* const kStoredRecentMessage;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
