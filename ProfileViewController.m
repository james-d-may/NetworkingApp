//
//  ProfileViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 21/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFUser *current = [PFUser currentUser];
    self.lblName.text = [current valueForKey:@"Name"];
    self.lblPosition.text = [current valueForKey:@"Position"];
    self.lblCompany.text = [current valueForKey:@"Company"];
    self.lblLocation.text = [current valueForKey:@"Location"];
    self.lblInterests.text = [current valueForKey:@"Interests"];
    
    PFFile *imageFile = [current valueForKey:@"ProfilePic"];
    NSData *imageData = [imageFile getData];
    UIImage *pic = [UIImage imageWithData:imageData];
    
    self.imageViewProfilePic.image = pic;
}

- (IBAction)buttonSettings:(id)sender {
    
    // Show action sheet for logging out
    UIActionSheet *settings = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Log Out", nil];
    [settings showFromTabBar:self.tabBarController.tabBar];
    //
    
}

# pragma mark - ActionSheet Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [PFUser logOut];
        [self performSegueWithIdentifier:@"showLogIn" sender:self];
    }
    
}


@end
