//
//  ServiceFormViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 7/22/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "ServiceFormViewController.h"

@interface ServiceFormViewController ()

@end

@implementation ServiceFormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setCategory:(NSString *)category {
    
    categoryStr = category;
}

- (void)setDescription:(NSString *)description {
    descriptionStr = description;
}

- (void)viewDidLoad
{   //Testing Only!
    /*
    nameText.text = @"Cory Ginsberg";
    busNameText.text = @"Any Apps R Us";
    addrLn1Text.text = @"19 Bedford dr";
    //addrLn2Text.text = @"apt.26B or C/O John Smith";
    cityAddrText.text = @"Vernon Hills";
    zipAddrText.text = @"60061";
    phoneNumberText.text = @"18476808462";
    emailText.text = @"coryginsberg@yahoo.com";
     */
    
    [super viewDidLoad];
    self.title = categoryStr;
    
    [nameText setDoneBarButtonEnabled:NO];
    [busNameText setDoneBarButtonEnabled:NO];
    [phoneNumberText setDoneBarButtonEnabled:NO];
    [emailText setDoneBarButtonEnabled:NO];
    [addrLn1Text setDoneBarButtonEnabled:NO];
    [addrLn2Text setDoneBarButtonEnabled:NO];
    [cityAddrText setDoneBarButtonEnabled:NO];
    [zipAddrText setDoneBarButtonEnabled:YES];
    
    [zipAddrText setMaximumLength:5];

    [nameText becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"submit" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewChanges:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(submitBtnTapped:)
                                                 name:@"submit"
                                               object:nil];
}

- (void)textViewChanges:(id)notification {
    
    //you can implement logic here.
    NSArray *textFields = @[nameText, phoneNumberText, emailText, addrLn1Text, cityAddrText, zipAddrText];
    int numUsed = 0;
    for (DPTextField *textField in textFields) if (![textField.text isEqual: @""] && textField.text != nil) numUsed++;
    if (numUsed == 6) [btnSubmit setEnabled:YES];
    else [btnSubmit setEnabled:NO];
}


- (IBAction)submitBtnTapped:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"submitDone" object:self];
    
    NSMutableString *strMessage = [NSMutableString stringWithFormat:@"%@\n\n", descriptionStr];
    [strMessage appendFormat:@"%@\n", nameText.text];
    if (![busNameText.text isEqual: @""])
        [strMessage appendFormat:@"%@\n", busNameText.text];
    [strMessage appendFormat:@"%@\n",addrLn1Text.text];
    if (![addrLn2Text.text isEqual: @""])
        [strMessage appendFormat:@"%@\n",addrLn2Text.text];
    [strMessage appendFormat:@"%@, Il\n", cityAddrText.text];
    [strMessage appendFormat:@"%@\n\n", zipAddrText.text];
    [strMessage appendFormat:@"Phone: %@\n", phoneNumberText.text];
    [strMessage appendFormat:@"Email: %@", emailText.text];
    
    // Loads the Mail View Controller
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:@[@"assurhvac@aol.com"]]; // Use only when done!
        //[controller setToRecipients:@[@"cory.ginsberg1@gmail.com"]];
        [controller setSubject:categoryStr];
        [controller setMessageBody:strMessage isHTML:NO];
        if (controller) [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"Email sent!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Sent Successfully" message:@" Thank you for your business. We will contact you for more information as soon as possible." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else if (result == MFMailComposeResultFailed && MFMailComposeErrorCodeSendFailed) {
        NSLog(@"Email not sent! Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Not Sent" message:@"Due to an error, the request was not sent. Please make sure you are connected to the internet and try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)viewDidUnload {
    nameText = nil;
    phoneNumberText = nil;
    emailText = nil;
    addrLn1Text = nil;
    addrLn2Text = nil;
    cityAddrText = nil;
    zipAddrText = nil;
    btnSubmit = nil;
    [super viewDidUnload];
}

@end
