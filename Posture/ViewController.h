//
//  ViewController.h
//  Posture
//
//  Created by Kevin Le on 4/4/15.
//  Copyright (c) 2015 Kevin Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

NSString* const kFaceCascadeName = @"haarcascade_frontalface_alt2";

#ifdef __cplusplus
cv::CascadeClassifier face_cascade;
#endif

@interface ViewController : UIViewController <CvVideoCameraDelegate>
{
    IBOutlet UIImageView* imageView;
    IBOutlet UIButton* button;
    
    CvVideoCamera* videoCamera;
}

- (IBAction)actionStart:(id)sender;

@property (nonatomic, strong) CvVideoCamera* videoCamera;

@end

