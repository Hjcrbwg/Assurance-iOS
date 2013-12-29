//
//  HomeViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/8/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () {

}

@end

@implementation AboutUsViewController
@synthesize map;

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
    map.delegate = self;
    map.showsUserLocation = YES;
    
    CLLocationCoordinate2D annotationCoord = CLLocationCoordinate2DMake(42.091122, -87.812767);

    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"Assurance Heating & A/C";
    annotationPoint.subtitle = @"1953 Johns Dr, Glenview, Il";
    [map addAnnotation:annotationPoint];
    
    [self.navigationController.navigationBar.topItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AssuranceNavBar"]]];
    
    self.navigationController.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    self.tabBarController.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	// Do any additional setup after loading the view.
    MKCoordinateRegion chicagoland = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(42.091122, -87.812767), 75000, 75000);
    [map setRegion:chicagoland animated:YES];
    [map setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    map = nil;
    [super viewDidUnload];
}
- (IBAction)websiteTapped:(id)sender {
    BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://assurancehvac.com"]];
    if (canOpenURL) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.assurancehvac.com"]];
    }
}
@end
