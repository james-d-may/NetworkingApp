//
//  AttendeeDetailViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AttendeeDetailViewController : UIViewController

@property (nonatomic,strong) PFUser *selectedUser;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPosition;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblInterests;
@property (strong, nonatomic) IBOutlet UILabel *lblCompany;

@property (strong, nonatomic) IBOutlet UINavigationItem *lblNav;

@end
