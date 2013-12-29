//
//  HomeViewController.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/8/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface AboutUsViewController : UIViewController <MKMapViewDelegate> {
    
    MKMapView *map;
}

@property (strong, nonatomic) IBOutlet MKMapView *map;
- (IBAction)websiteTapped:(id)sender;


@end
