//
//  EventCreateViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "NetworkCreateViewController.h"
#import "UIImage+QRCodeGenerator.h"

@interface NetworkCreateViewController ()

@end

@implementation NetworkCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFieldInput.delegate = self;
    
}



- (IBAction)buttonGenerate:(id)sender {
    
    // Generate a QRCode from text field input, with chosen colours, and assign it to the imageview
    self.imageViewQRCode.image = [UIImage QRCodeGenerator:self.textFieldInput.text
                                           andLightColour:[UIColor whiteColor]
                                            andDarkColour:[UIColor blackColor]
                                             andQuietZone:1
                                                  andSize:300];
    
    UIImageWriteToSavedPhotosAlbum(self.imageViewQRCode.image, nil, nil, nil);

    
}

# pragma mark - UITextField delegate methods

// Makes the keyboard dissapear once return is pressed //
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
