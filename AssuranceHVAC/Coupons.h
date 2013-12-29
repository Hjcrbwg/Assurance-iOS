//
//  Coupons.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 11/3/13.
//  Copyright (c) 2013 Boiling Point Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Coupons : NSObject

@property (nonatomic, strong) NSArray *couponArray;

- (NSArray *) getCoupons;
- (NSString *) getFileName:(UIImage *)img;
- (NSArray *) getCouponTitles;

@end
