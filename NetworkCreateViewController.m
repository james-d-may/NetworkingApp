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
    
    int random = (arc4random() %99999999)+100000000;
    NSLog(@"random number:%d",random);
    NSString *networkId = [NSString stringWithFormat:@"%d",random];
    
    // Generate a QRCode from text field input, with chosen colours, and assign it to the imageview
    self.imageViewQRCode.image = [UIImage QRCodeGenerator:networkId
                                           andLightColour:[UIColor whiteColor]
                                            andDarkColour:[UIColor blackColor]
                                             andQuietZone:1
                                                  andSize:300];
    
    UIImageWriteToSavedPhotosAlbum(self.imageViewQRCode.image, nil, nil, nil);
    
    // Create a piece of data from the qrcode image
    NSData *fileData = UIImageJPEGRepresentation (self.imageViewQRCode.image , 1);
    
    // Set variables for network object
    NSString *networkName = self.textFieldInput.text;
    PFFile *file = [PFFile fileWithData:fileData];
    
    // Create new network/event object in Parse with name, and qrcode.
    PFObject *network = [PFObject objectWithClassName:@"Networks"];
    [network setObject:networkName forKey:@"NetworkName"];
    [network setObject:networkId forKey:@"NetworkId"];
    [network setObject:file forKey:@"QRCode"];
    
    [network saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops Try Again!" message:@"Please try generating again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            
        } else {
            
            UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You have created a new network with an associated QRCode. Put the QRCode on a poster at your event, and start emailing it to attendees." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView2 show];
        
        }
    }];

    
}

# pragma mark - UITextField delegate methods

// Makes the keyboard dissapear once return is pressed //
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
