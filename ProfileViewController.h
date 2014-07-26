//
//  ProfileViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 21/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <UIActionSheetDelegate>

- (IBAction)buttonSettings:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPosition;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblInterests;
@property (strong, nonatomic) IBOutlet UILabel *lblCompany;

@end
