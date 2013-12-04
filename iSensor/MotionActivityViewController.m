//
//  MotionActivityViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/26.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "MotionActivityViewController.h"

@interface MotionActivityViewController ()

@end

@implementation MotionActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 歩数カウント開始
    [self startStepCounting];
    
    // 移動状況取得開始
    [self startUpdatingActivity];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // 取得を停止
    [_stepCounter stopStepCountingUpdates];
    [_activityManager stopActivityUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStepCounting
{
    if (![CMStepCounter isStepCountingAvailable])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"CMStepCounter is unavailable."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // ブロックによる循環参照の回避
    __weak typeof(self) weakSelf = self;
    
    _stepCounter = [[CMStepCounter alloc] init];
    [_stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue]
                                         updateOn:1
                                      withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                          weakSelf.stepLabel.text = [NSString stringWithFormat:@"Step: %d", numberOfSteps];
                                      }];
}

- (void)startUpdatingActivity
{
    if (![CMMotionActivityManager isActivityAvailable])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"CMMotionActivityManager is unavailable."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    // ブロックによる循環参照の回避
    __weak typeof(self) weakSelf = self;

    _activityManager = [[CMMotionActivityManager alloc] init];
    [_activityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue]
                                      withHandler:^(CMMotionActivity *activity) {
                                          weakSelf.confidenceLabel.text = [NSString stringWithFormat:@"confidence: %d", activity.confidence];
                                          weakSelf.stationaryLabel.text = [NSString stringWithFormat:@"stationary: %d", activity.stationary];
                                          weakSelf.walkingLabel.text = [NSString stringWithFormat:@"walking: %d", activity.walking];
                                          weakSelf.runningLabel.text = [NSString stringWithFormat:@"running: %d", activity.running];
                                          weakSelf.automotiveLabel.text = [NSString stringWithFormat:@"automotive: %d", activity.automotive];
                                          weakSelf.unknowLabel.text = [NSString stringWithFormat:@"unknow: %d", activity.unknown];
     }];

}

@end
