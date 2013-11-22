//
//  AltitudeViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/22.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "AltitudeViewController.h"

@interface AltitudeViewController ()

@end

@implementation AltitudeViewController

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

    if ([CLLocationManager headingAvailable])
    {
        // インスタンスを生成
        _locationManager = [[CLLocationManager alloc] init];

        // デリゲートを設定
        _locationManager.delegate = self;

        // 何度動いたら更新するか（デフォルトは1度）
        _locationManager.headingFilter = kCLHeadingFilterNone;

        // デバイスの度の向きを北とするか（デフォルトは画面上部）
        _locationManager.headingOrientation = CLDeviceOrientationPortrait;

        // ヘディングイベントの開始
        [_locationManager startUpdatingLocation];
    }

}
// 止める処理
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // ヘディングイベントの停止
    if ([CLLocationManager headingAvailable]) {
        [_locationManager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"newLocation %f", newLocation.altitude);
    self.textField.text = [NSString stringWithFormat:@"%f", newLocation.altitude];
}

@end
