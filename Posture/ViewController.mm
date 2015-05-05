//
//  ViewController.m
//  Posture
//
//  Created by Kevin Le on 4/4/15.
//  Copyright (c) 2015 Kevin Le. All rights reserved.
//

#import "ViewController.h"
#define FPS 15
#define MAX_CENTER_DIFF 25
#define MAX_WIDTH_DIFF 25
#define MAX_HEIGHT_DIFF 25

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
    self.videoCamera.defaultFPS = FPS;
    self.videoCamera.grayscaleMode = NO;
    
    NSString *faceCascadePath = [[NSBundle mainBundle] pathForResource:kFaceCascadeName ofType:@"xml"];
    
    if(!face_cascade.load([faceCascadePath UTF8String])) {
        NSLog(@"Could not load face classifier!");
    }
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
    static int frame = 1;
    static cv::Mat base;
    
    if (frame < FPS * 1) {
        cv::putText(image, "1", cv::Point(120, 200), cv::FONT_HERSHEY_SIMPLEX, 3, cv::Scalar(0,0,255), 3);
    }
    else if (frame < FPS * 2) {
        cv::putText(image, "2", cv::Point(120, 200), cv::FONT_HERSHEY_SIMPLEX, 3, cv::Scalar(0,0,255), 3);
    }
    else if (frame < FPS * 3) {
        cv::putText(image, "3", cv::Point(120, 200), cv::FONT_HERSHEY_SIMPLEX, 3, cv::Scalar(0,0,255), 3);
    }
    else if (frame < FPS * 4) {
        cv::putText(image, "4", cv::Point(120, 200), cv::FONT_HERSHEY_SIMPLEX, 3, cv::Scalar(0,0,255), 3);
    }
    else if (frame < FPS * 5) {
        cv::putText(image, "5", cv::Point(120, 200), cv::FONT_HERSHEY_SIMPLEX, 3, cv::Scalar(0,0,255), 3);
        base = image.clone();
    }
    
    std::vector<cv::Rect> baseFaces;
    face_cascade.detectMultiScale(base, baseFaces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    // Detect faces
    std::vector<cv::Rect> faces;
    face_cascade.detectMultiScale(image, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    // Draw circles on the detected faces
    for(int i = 0; i < faces.size(); i++)
    {
        for (int j = 0; j < baseFaces.size(); j++) {
            if (i == j) {
                cv::Point center(faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5);
                cv::ellipse(image, center, cv::Size(faces[i].width*0.5,
                                                     faces[i].height*0.5), 0, 0, 360, cv::Scalar(255, 0, 0), 4, 8, 0);
                
                cv::Point baseCenter(baseFaces[j].x + baseFaces[j].width*0.5, baseFaces[j].y + baseFaces[j].height*0.5);
                cv::ellipse(image, baseCenter, cv::Size(baseFaces[j].width*0.5,
                                                     baseFaces[j].height*0.5), 0, 0, 360, cv::Scalar(0, 0, 255), 4, 8, 0);
                
                if (cv::norm(baseCenter - center) > MAX_CENTER_DIFF ||
                    cv::norm(baseFaces[j].width - faces[i].width) > MAX_WIDTH_DIFF ||
                    cv::norm(baseFaces[j].height - faces[j].height) > MAX_HEIGHT_DIFF) {
                    cv::putText(image, "Bad", cv::Point(100, 275), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0,0,0), 2);
                    cv::putText(image, "posture", cv::Point(100, 325), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0,0,0), 2);
                    printf("Bad Posture!\n");
                }
                else {
                    cv::putText(image, "Good", cv::Point(100, 275), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0,0,0), 2);
                    cv::putText(image, "posture", cv::Point(100, 325), cv::FONT_HERSHEY_SIMPLEX, 1, cv::Scalar(0,0,0), 2);
                    printf("Bad Posture!\n");
                    printf("Good Posture!\n");
                }
            }
        }
        cv::Canny(image, image, 160, 160);
    }
    frame++;
}
#endif

@end
