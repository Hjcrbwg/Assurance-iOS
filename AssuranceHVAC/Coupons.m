//
//  Coupons.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 11/3/13.
//  Copyright (c) 2013 Boiling Point Entertainment. All rights reserved.
//

#import "Coupons.h"

@implementation Coupons
@synthesize couponArray = _couponArray;

- (NSArray *) getCoupons {
    
    UIImage *couponOne = [UIImage imageNamed:@"20% Off"];
    UIImage *couponTwo = [UIImage imageNamed:@"$89"];
    UIImage *couponThree = [UIImage imageNamed:@"$250 Off"];
    
    self.couponArray = @[couponOne,
                         couponTwo,
                         couponThree];
    
    return self.couponArray;
}

- (NSArray *) getCouponTitles {
    
    NSString *titleCouponOne = @"20% Off";
    NSString *titleCouponTwo = @"$89";
    NSString *titleCouponThree = @"$250 Off";
    
    NSArray *titleArray = @[titleCouponOne,
                            titleCouponTwo,
                            titleCouponThree];
    return titleArray;
}

- (NSString *) getFileName:(UIImageView *)imgView {
    
    NSString *imgName = [imgView image].accessibilityIdentifier;
    
    return imgName;
    
}

@end
