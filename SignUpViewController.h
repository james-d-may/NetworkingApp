//
//  SignUpViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 25/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) UIImage *profilePic;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPos;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCompany;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLocation;
@property (weak, nonatomic) IBOutlet UITextView *textViewInterests;
@property (weak, nonatomic) IBOutlet UIButton *buttonUploadTitle;

- (IBAction)upload:(id)sender;
- (IBAction)signUp:(id)sender;
- (IBAction)cancel:(id)sender;

@end
