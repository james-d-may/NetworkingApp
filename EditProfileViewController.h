//
//  EditProfileViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 05/08/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface EditProfileViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPosition;
@property (strong, nonatomic) IBOutlet UITextField *textFieldLocation;
@property (strong, nonatomic) IBOutlet UITextView *textViewInterests;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCompany;

@end
