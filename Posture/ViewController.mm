//
//  ViewController.m
//  Posture
//
//  Created by Kevin Le on 4/4/15.
//  Copyright (c) 2015 Kevin Le. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize videoCamera;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    
}

#pragma mark - UI Actions

- (IBAction)actionStart:(id)sender;
{
    [self.videoCamera start];
    NSLog(@"video camera running: %d", [self.videoCamera running]);
    NSLog(@"capture session loaded: %d", [self.videoCamera captureSessionLoaded]);
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(cv::Mat&)image
{
    cv::Canny(image, image, 160, 160);
}
#endif

@end
