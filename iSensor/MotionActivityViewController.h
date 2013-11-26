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

@end
