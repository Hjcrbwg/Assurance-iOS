//
//  AppDelegate.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 6/23/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "AppDelegate.h"
#import "Helpshift.h"
#import "TestFlight.h"
@import AddressBook;
@import AddressBookUI;

#define StringFromBOOL(b) ((b) ? @"YES" : @"NO")
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [TestFlight takeOff:@"04175fa8-6dea-4263-967b-08fba46f8ec2"];
    
    [Helpshift installForAppID:@"anyappsrus_platform_20131016200123607-3e51e31cc9629b2"
                    domainName:@"anyappsrus.helpshift.com"
                        apiKey:@"4fc9edf04f5c17201d7c8da90c93d882"];
    
    // Shows alert if:
    // @"remind" bool = NO (user does not want to be reminded again) or,
    // [AssuranceContact isContactCreated] = No (contact is not found)
    remindAgain = [NSUserDefaults standardUserDefaults];
    if (![remindAgain boolForKey:@"remind"] || ![AssuranceContact isContactCreated]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Create Contact" message:@"Would you like to add our contact to your Address Book for future reference?" delegate:self cancelButtonTitle:@"Remind Me Later" otherButtonTitles:@"Yes", @"Don't Remind me Again", nil];
        [alert show];
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%ld", (long)buttonIndex);
    if (alertView == alert) {
        switch (buttonIndex) {
            case 1:
                [[[AssuranceContact alloc] init] createContact];
                break;
            case 2:
                [remindAgain setBool:YES forKey:@"remind"];
                [remindAgain synchronize];
                break;
            default:
                break;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
