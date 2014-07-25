//
//  EventCreateViewController.h
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NetworkCreateViewController : UIViewController <UITextFieldDelegate>

- (IBAction)buttonGenerate:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textFieldInput;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewQRCode;


@end
