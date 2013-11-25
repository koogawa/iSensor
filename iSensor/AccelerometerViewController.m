//
//  AccelerometerViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/26.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "AccelerometerViewController.h"

@interface AccelerometerViewController ()

@end

@implementation AccelerometerViewController

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

    // インスタンスの生成
    _motionManager = [[CMMotionManager alloc] init];

    if (_motionManager.accelerometerAvailable)
    {
        // センサーの更新間隔の指定
        _motionManager.accelerometerUpdateInterval = 1 / 10;  // 10Hz

        // ハンドラを指定
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error)
        {
            // 画面に表示
            self.xLabel.text = [NSString stringWithFormat:@"x %f", data.acceleration.x];
            self.yLabel.text = [NSString stringWithFormat:@"y %f", data.acceleration.y];
            self.zLabel.text = [NSString stringWithFormat:@"z %f", data.acceleration.z];
        };

        // 加速度の取得開始
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // 加速度の取得停止
    if (_motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
