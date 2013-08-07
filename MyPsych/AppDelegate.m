//
//  AppDelegate.m
//  MyPsych
//
//  Created by James Lockwood on 5/8/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "AppDelegate.h"
#import "ProfileDataManager.h"
#import "TestFlight.h"

#define TESTING 0

NSString* const kHasShownAccountInfoKey = @"hasShownAccountInfo";
NSString* const kHasShownIntroScreenKey = @"hasShownIntroScreen";
NSString* const kUDIDStoreKey           = @"udidStoreKey";
NSString* const kClientPINStoreKey      = @"clientPINStoreKey";
NSString* const kClientIDStoreKey       = @"clientIDStoreKey";
NSString* const kStoredRecentMessage    = @"kStoredRecentMessage";

@implementation AppDelegate

@synthesize window = _window;

- (void)generateUDIDIfNeeded {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kUDIDStoreKey]) {
        CFUUIDRef udid = CFUUIDCreate(NULL);
        NSString *udidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, udid));
        [defaults setObject:udidString forKey:kUDIDStoreKey];
        [defaults synchronize];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
#if TESTING
    // [TestFlight takeOff:@"49383184388bdbe55a6cae95fba5da87_ODk4MzMyMDEyLTA1LTEzIDE1OjA5OjA2LjQ1OTE2NA"];
    // [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
#endif
    
    [self generateUDIDIfNeeded];
    [ProfileDataManager resetBadgeAlert];
    [[ProfileDataManager sharedManager] loadDataFromDisk];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[ProfileDataManager sharedManager] saveDataToDisk];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[ProfileDataManager sharedManager] saveDataToDisk];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[ProfileDataManager sharedManager] saveDataToDisk];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
