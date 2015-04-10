//
//  ViewController.h
//  Posture
//
//  Created by Kevin Le on 4/4/15.
//  Copyright (c) 2015 Kevin Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

@interface ViewController : UIViewController <CvVideoCameraDelegate>
{
    IBOutlet UIImageView* imageView;
    IBOutlet UIButton* button;
    
    CvVideoCamera* videoCamera;
}

- (IBAction)actionStart:(id)sender;

@property (nonatomic, strong) CvVideoCamera* videoCamera;

@end

