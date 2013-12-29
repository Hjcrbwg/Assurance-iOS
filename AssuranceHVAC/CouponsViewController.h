//
//  CouponsViewController.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 10/6/13.
//  Copyright (c) 2013 Boiling Point Entertainment. All rights reserved.
//

@import UIKit;
@import Foundation;

@protocol CouponsViewControllerDelegate <NSObject>
@end

@interface CouponsViewController : UIViewController {
    
}

@property (strong, nonatomic) IBOutlet UIImageView *couponView;
@property (nonatomic, assign) id<CouponsViewControllerDelegate> delegate;

- (IBAction)activityBtnPressed:(id)sender;

@end
