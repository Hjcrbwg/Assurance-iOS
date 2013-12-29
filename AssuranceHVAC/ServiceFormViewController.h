//
//  ServiceFormViewController.h
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 7/22/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "DPTextField.h"

@import UIKit;
@import MessageUI;

@interface ServiceFormViewController : UITableViewController <MFMailComposeViewControllerDelegate,UITextFieldDelegate, UITextViewDelegate> {
    
    IBOutlet DPTextField *nameText;
    IBOutlet DPTextField *busNameText;
    IBOutlet DPTextField *phoneNumberText;
    IBOutlet DPTextField *emailText;
    IBOutlet DPTextField *addrLn1Text;
    IBOutlet DPTextField *addrLn2Text;
    IBOutlet DPTextField *cityAddrText;
    IBOutlet DPTextField *zipAddrText;
    
    IBOutlet UIBarButtonItem *btnSubmit;
    
    NSString* categoryStr;
    NSString* descriptionStr;

}

- (IBAction)submitBtnTapped:(id)sender;
- (void)setCategory:(NSString *)category;
- (void)setDescription:(NSString *)description;

@end
