//
//  QRCodeReaderViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 24/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "QRCodeReaderViewController.h"
#import <Parse/Parse.h>

@interface QRCodeReaderViewController ()

@property (nonatomic) BOOL isReading;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation QRCodeReaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.captureSession = nil;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    if (!_isReading) {
        
        
        // If app isn't currently reading then start reading and change respective labels and button titles, else stop.
        if ([self startReading]) {

        }
    } else {
        [self stopReading];
    }
    
    _isReading = !_isReading;
    
}

- (BOOL)startReading {
    
    // Set up an error
    NSError *error;
    // Access device for video
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Create an input, which in this case is the camera
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    // If there is no input then end method
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // Create capture session and add input to it
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    
    // Create and add output to session
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    // Create a dispatch queue to be used totally by the task
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // Set meta data we are interested in to QRCodes
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Create a video preview layer
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    // Start running the session
    [_captureSession startRunning];
    
    return YES;
    
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    
    [_videoPreviewLayer removeFromSuperlayer];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Perform actions if the output array isnt nil, and there is an object
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        // Make sure meta object is a QRCode
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            // Get network id from meta object
            NSString *networkId = [NSString stringWithFormat:@"%@",[metadataObj stringValue]];
            NSLog(@"%@",networkId);
            
            // Query and find network with networkId
            PFQuery *query = [PFQuery queryWithClassName:@"Networks"];
            [query whereKey:@"NetworkId" equalTo:networkId];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(error) {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                    
                } else {
                    
                    // Set user object, set relation
                    PFUser *user = [PFUser currentUser];
                    PFRelation *relation = [user relationForKey:@"JoinedNetworks"];
                    
                    for (PFObject *object in objects) {
                        
                        // Add event object to user
                        [relation addObject:object];
                        
                        // Add user to event
                        PFRelation *eventRelation = [object relationForKey:@"JoinedUsers"];
                        [eventRelation addObject:user];
                        [object saveInBackground];
                        
                    }
                    // Save user 
                    [user saveInBackground];
                    
                }
            }];
            
            
            
//            // Change the status label to the meta objects string value on the main thread
//            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            // Run stop reading on the main thread
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            _isReading = NO;
            
        }
        
        
    }
}


- (IBAction)buttonCancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
