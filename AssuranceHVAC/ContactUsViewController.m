//
//  ContactUsViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 6/23/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "ContactUsViewController.h"
#import "Helpshift.h"
#import "Coupons.h"

@import AddressBook;
@import AddressBookUI;

@interface ContactUsViewController () {
    NSTimer *couponTimer;
    
    NSUserDefaults *userDefaults;
}

@end

#define is4Inch  ([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO

@implementation ContactUsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController.navigationBar.topItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssuranceNavBar"]]];
    
    alert.delegate = self; // Needed to detect which button was tapped on UIAlertView dismisal
    [self loadScrollView];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    self.tabBarController.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
    [couponTimer invalidate];
    scrollView = nil;
    //couponTimer = nil;
}

-(void)scrollToPage:(NSInteger)aPage {
    float myPageWidth = [scrollView frame].size.width;
    [scrollView setContentOffset:CGPointMake(aPage*myPageWidth,scrollView.frame.origin.y)
                        animated:YES];
}

- (NSArray *)coupons {
    
    Coupons *coupons = [[Coupons alloc] init];
    couponsArray = [[NSMutableArray alloc] init];
    userDefaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i < coupons.getCoupons.count; i++) {
        UIButton *btn;
        if (is4Inch)
            btn= [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 150)];
        else
            btn= [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 80)];
        
        [btn setBackgroundImage:[coupons.getCoupons objectAtIndex:i]
                       forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(couponSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i+1];
        [btn setTitle:[coupons getFileName:btn.imageView.image] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [userDefaults setInteger:i forKey:[NSString stringWithFormat:@"%d", i]];
        [couponsArray insertObject:btn atIndex:i];

    }
    
    return couponsArray;
}

- (IBAction)couponSelected:(id)sender {
    //Get the buttons' titles.
    Coupons *coupons = [[Coupons alloc] init];
    for (int i = 0; i < coupons.getCoupons.count; i++) {
        if ([sender tag]-1 == i) {
            userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setInteger:i forKey:@"coupon"];
        }
    }

    [self performSegueWithIdentifier:@"showCoupon" sender:self];

}

// Loads Coupons
- (void)loadScrollView {
    
    //create the scrollview with specific frame
    if (is4Inch)
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 152)];
    else
        scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 80)];
    
    //array for views to add to the scrollview    //array for views to add to the scrollview
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    //cycle which creates views for the scrollview
    for (int i = 0; i < [self coupons].count; i++)
    {
        UIView *view;
        if (is4Inch)
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 155)];
        else
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 87)];
        [view addSubview:[[self coupons] objectAtIndex:i]];
        [views addObject:view];
    }
    
    // Comment Out When Testing Coupons
    // Sets when to swap out each coupon from view
    /// ON RELEASE: set interval: 5
    couponTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                   target:self
                                                 selector:@selector(updateCounter:)
                                                 userInfo:nil
                                                  repeats:YES];
    
    //add pages to scrollview
    [scrollView addPages:views];
    
    //add scrollview to the view
    [self.view addSubview:scrollView];
    [scrollView setHasPageControl:YES];
    [scrollView addPages:views];
    
    //set color for scroll view
    [scrollView setPageControlCurrentPageColor:[UIColor darkGrayColor]];
    [scrollView setPageControlOtherPagesColor:[UIColor lightGrayColor]];
    
    views = nil;
}

// Switches which coupon is showing automatically
- (void)updateCounter:(NSTimer *)theTimer {
    if (![[UIScrollView alloc] isDragging]) {
        NSInteger numberOfViews = 3;
        static int i = 0; i++;
        
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        if (i < numberOfViews) {
            [scrollView scrollRectToVisible:CGRectMake((page + 1)  * self.view.frame.size.width,
                                                       0,
                                                       self.view.frame.size.width,
                                                       self.view.frame.size.height)
                                   animated:YES];
        } else {
            i = 0;
            [scrollView scrollRectToVisible:CGRectMake(0,
                                                       0,
                                                       self.view.frame.size.width,
                                                       self.view.frame.size.height)
                                   animated:YES];
        }
    }
    return;

}

-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Emergency

- (IBAction)emergency:(id)sender {
    
    // If device can make calls
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Are you sure want to make an emergency call?"
                                           message:nil
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes", nil];
        [alert show];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Unable to Make Calls"
                                           message:@"This device is unable to make phone calls. Please use a phone to dial (847)729-4328"
                                          delegate:nil
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
        [alert show];
    }
    
    [Helpshift leaveBreadCrumb:@"Pressed Emergency Button"];
}

- (IBAction)help:(id)sender {
    
    [[Helpshift sharedInstance] showFAQs:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 1)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(847)729-4328"]];
}

@end
