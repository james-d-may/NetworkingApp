//
//  EditProfileViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 05/08/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textFieldName.delegate = self;
    self.textFieldPosition.delegate = self;
    self.textFieldCompany.delegate = self;
    self.textFieldLocation.delegate = self;
    self.textViewInterests.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFUser *current = [PFUser currentUser];
    self.textFieldName.text = [current valueForKey:@"Name"];
    self.textFieldPosition.text = [current valueForKey:@"Position"];
    self.textFieldCompany.text = [current valueForKey:@"Company"];
    self.textFieldLocation.text = [current valueForKey:@"Location"];
    self.textViewInterests.text = [current valueForKey:@"Interests"];
    
    PFFile *imageFile = [current valueForKey:@"ProfilePic"];
    NSData *imageData = [imageFile getData];
    UIImage *pic = [UIImage imageWithData:imageData];
    
    self.imageViewProfilePic.image = pic;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    PFUser *updated = [PFUser currentUser];
    [updated setValue:self.textFieldName.text forKey:@"Name"];
    [updated setValue:self.textFieldPosition.text forKey:@"Position"];
    [updated setValue:self.textFieldCompany.text forKey:@"Company"];
    [updated setValue:self.textFieldLocation.text forKey:@"Location"];
    [updated setValue:self.textViewInterests.text forKey:@"Interests"];
    
    [updated saveInBackground];
    
}

# pragma mark - UITextField delegate methods

// Makes the keyboard dissapear once return is pressed //
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



@end
