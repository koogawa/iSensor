//
//  MotionActivityViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/26.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionActivityViewController : UIViewController
{
    CMStepCounter           *_stepCounter;
    CMMotionActivityManager *_activityManager;
}

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@property (weak, nonatomic) IBOutlet UILabel *stationaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *walkingLabel;
@property (weak, nonatomic) IBOutlet UILabel *runningLabel;
@property (weak, nonatomic) IBOutlet UILabel *automotiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *unknowLabel;

@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;

@end
