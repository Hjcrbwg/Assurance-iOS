//
//  AppDelegate.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 6/23/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "AssuranceContact.h"

@import UIKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    UIAlertView *alert;
    NSUserDefaults *remindAgain;
}

@property (strong, nonatomic) UIWindow *window;



@end
