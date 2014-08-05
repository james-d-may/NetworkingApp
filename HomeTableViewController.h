//
//  HomeTableViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 21/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AttendeeDetailViewController.h"

@interface HomeTableViewController : UITableViewController

@property (nonatomic,strong) PFUser *currentUser;
@property (nonatomic,strong) PFUser *selectedUser;
@property (nonatomic,strong) NSArray *joinedUsers;
@property (strong,nonatomic) PFObject *latestNetwork;

@end
