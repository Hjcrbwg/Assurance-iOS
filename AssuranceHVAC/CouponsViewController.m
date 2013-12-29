//
//  CouponsViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 10/6/13.
//  Copyright (c) 2013 Boiling Point Entertainment. All rights reserved.
//

#import "CouponsViewController.h"
#import "Coupons.h"

@interface CouponsViewController () {
    UIImage *currentCoupon;
}

@end

@implementation CouponsViewController
@synthesize delegate = _delegate;
@synthesize couponView = _couponView;

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
	// Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    Coupons *coupons = [[Coupons alloc] init];
    for (int i = 0; i < [coupons getCoupons].count; i++) {
        UIImage *selectedCoupon = [[coupons getCoupons] objectAtIndex:i];
        [coupons.getCoupons objectAtIndex:i];
        if ([userDefaults integerForKey:@"coupon"] == i) {
            [self.couponView setImage:selectedCoupon];
            [self setTitle:[[coupons getCouponTitles] objectAtIndex:i]];
            NSLog(@"%@", [[coupons getCouponTitles] objectAtIndex:i]);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)activityBtnPressed:(id)sender {
    
    UIImage *imageToSend = [UIImage imageNamed:[NSString stringWithFormat:@"%@ Print", self.title]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imageToSend] applicationActivities:nil];
    
    // Exclude whichever activities are not needed.
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypePostToTwitter,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToWeibo,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:YES completion:nil];

}

@end
