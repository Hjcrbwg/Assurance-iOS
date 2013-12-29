//
//  ServiceInfoViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/9/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "ServiceInfoViewController.h"
#import "ServiceFormViewController.h"

@interface ServiceInfoViewController ()

@end

@implementation ServiceInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setCategory:(NSString *)category {
    
    categoryStr = category;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = categoryStr;
	// Do any additional setup after loading the view.
    int keyboardHeight = 217;
    [self.infoTextField setFrame:CGRectMake(self.infoTextField.frame.origin.x, self.infoTextField.frame.origin.y, self.infoTextField.frame.size.width, self.view.frame.size.height - keyboardHeight)];
    [self.infoTextField becomeFirstResponder];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int keyboardHeight = 217;
    [self.infoView setFrame:CGRectMake(self.infoTextField.frame.origin.x, self.infoTextField.frame.origin.y, self.infoTextField.frame.size.width, self.view.frame.size.height)];
    return self.view.frame.size.height - keyboardHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // tell the destination view controller what category to display
    [(ServiceFormViewController*)segue.destinationViewController setCategory:categoryStr];
    [(ServiceFormViewController*)segue.destinationViewController setDescription:self.infoTextField.text];

}

- (void)viewDidUnload {
    [self setInfoTextField:nil];
    [self setInfoCell:nil];
    [self setInfoView:nil];
    [super viewDidUnload];
}
@end
