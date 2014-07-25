//
//  LogInViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

- (IBAction)logIn:(id)sender;
- (IBAction)signUp:(id)sender;

@end
