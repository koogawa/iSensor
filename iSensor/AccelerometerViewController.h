//
//  AccelerometerViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/26.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AccelerometerViewController : UIViewController
{
    CMMotionManager *_motionManager;
}

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@end
