//
//  ServiceInfoViewController.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/9/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@import UIKit;

@interface ServiceInfoViewController : UITableViewController <UITextViewDelegate> {
    NSString *categoryStr;
}

@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *infoTextField;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UITableViewCell *infoCell;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

- (void)setCategory:(NSString *)category;

@end
