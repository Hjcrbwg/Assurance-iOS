//
//  UIPlaceHolderTextView.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/5/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
