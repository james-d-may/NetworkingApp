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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
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
