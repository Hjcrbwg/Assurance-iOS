//
//  ContactUsViewController.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 6/23/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "ALScrollViewPaging.h"

@import UIKit;

@interface ContactUsViewController : UIViewController <UIScrollViewDelegate, UIAlertViewDelegate> {
    
    IBOutlet UIButton *btnEmergency;
    IBOutlet UIButton *btnService;
    NSArray *specialsArray;
    ALScrollViewPaging *scrollView;
    UIAlertView *alert;
    NSMutableArray *couponsArray;
}

- (IBAction)emergency:(id)sender;
- (IBAction)help:(id)sender;

@end
