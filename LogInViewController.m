//
//  LogInViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textFieldEmail.delegate = self;
    self.textFieldPassword.delegate = self;

    
}

- (IBAction)logIn:(id)sender {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    NSString *email = [self.textFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.textFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // If statment to check valid input and credentials //
    if ([email length] == 0 || [password length] == 0) {
        
        UIAlertView *inputAlertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you enter an email, and password."  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [inputAlertView show];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
    } else {
        
        [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                
                UIAlertView *newUserAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [newUserAlertView show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                
            } else {
                
                // Set owner property of parse cells for this installation //
                PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                [currentInstallation setObject:[PFUser currentUser].objectId forKey:@"owner"];
                [currentInstallation saveInBackground];
                //
                [self.navigationController popToRootViewControllerAnimated:YES];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            };
        }];
    };
    
}

- (IBAction)signUp:(id)sender {
    
    [self performSegueWithIdentifier:@"showSignUp" sender:self];
    
}

# pragma mark - UITextField delegate methods

// Makes the keyboard dissapear once return is pressed //
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
