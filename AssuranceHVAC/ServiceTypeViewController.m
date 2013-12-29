//
//  ServiceTypeViewController.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 7/23/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#import "ServiceTypeViewController.h"
#import "ServiceInfoViewController.h"

@interface ServiceTypeViewController ()

@end

@implementation ServiceTypeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self.tabBarController.tabBar setShadowImage:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    cellString = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"infoSegue" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // tell the destination view controller what category to display
    if ([segue.identifier isEqualToString:@"infoSegue"]) {
        [(ServiceInfoViewController*)segue.destinationViewController setCategory:cellString];
    }
}

@end
