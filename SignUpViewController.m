//
//  SignUpViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 25/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textFieldEmail.delegate = self;
    self.textFieldPassword.delegate = self;
    self.textFieldName.delegate = self;
    self.textFieldPos.delegate = self;
    self.textFieldCompany.delegate = self;
    self.textFieldLocation.delegate = self;
    self.textViewInterests.delegate = self;
}

- (IBAction)upload:(id)sender {
    
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *) kUTTypeImage, nil];
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
    
}

- (IBAction)signUp:(id)sender {
    
    NSString *email = [self.textFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.textFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *name = [self.textFieldName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *position = [self.textFieldPos.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *company = [self.textFieldCompany.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *location = [self.textFieldLocation.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *interests = [self.textViewInterests.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    // If statement to check valid input //
    if ([email length] == 0 || [password length] == 0 || [name length] == 0 || [position length] == 0 || [company length] == 0 || [location length] == 0 || [interests length] == 0) {
        
        UIAlertView *inputAlertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you fill out all the fields."  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [inputAlertView show];
    } else {
        
        [self.textFieldEmail resignFirstResponder];
        [self.textFieldPassword resignFirstResponder];
        [self.textFieldName resignFirstResponder];
        [self.textFieldPos resignFirstResponder];
        [self.textFieldCompany resignFirstResponder];
        [self.textFieldLocation resignFirstResponder];
        [self.textViewInterests resignFirstResponder];
        
        PFUser *newUser = [PFUser user];
        newUser.username = email;
        newUser.email = email;
        newUser.password = password;
        [newUser setObject:name forKey:@"Name"];
        [newUser setObject:position forKey:@"Position"];
        [newUser setObject:company forKey:@"Company"];
        [newUser setObject:location forKey:@"Location"];
        [newUser setObject:interests forKey:@"Interests"];

        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            NSLog (@" %d ", succeeded );
            
            if (error) {
                
                UIAlertView *newUserAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                
                [newUserAlertView show];
                
            } else {
                
                //Set owner property of parse cells for this installation
                PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                [currentInstallation setObject:[PFUser currentUser].objectId forKey:@"owner"];
                [currentInstallation saveInBackground];
                //
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
        }];

        
    }

    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

# pragma mark - UITextField delegate methods

// Makes the keyboard dissapear once return is pressed //
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
