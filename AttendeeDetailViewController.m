//
//  AttendeeDetailViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "AttendeeDetailViewController.h"

@interface AttendeeDetailViewController ()

@end

@implementation AttendeeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"selected user 2 %@ , name: %@", self.selectedUser,[self.selectedUser valueForKey:@"Name"] );
    
    self.lblName.text = [self.selectedUser valueForKey:@"Name"];
    self.lblPosition.text = [self.selectedUser valueForKey:@"Position"];
    self.lblCompany.text = [self.selectedUser valueForKey:@"Company"];
    self.lblLocation.text = [self.selectedUser valueForKey:@"Location"];
    self.lblInterests.text = [self.selectedUser valueForKey:@"Interests"];
    self.lblNav.title = [self.selectedUser valueForKey:@"Name"];
    
    PFFile *imageFile = [self.selectedUser valueForKey:@"ProfilePic"];
    NSData *imageData = [imageFile getData];
    UIImage *pic = [UIImage imageWithData:imageData];
    
    self.imageViewProfilePic.image = pic;
}

@end
