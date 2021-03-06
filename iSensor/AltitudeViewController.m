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

    if ([CLLocationManager locationServicesEnabled])
    {
        // インスタンスを生成
        _locationManager = [[CLLocationManager alloc] init];

        // デリゲートを設定
        _locationManager.delegate = self;

        // 位置情報の取得開始
        [_locationManager startUpdatingLocation];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // 位置情報の取得停止
    if ([CLLocationManager locationServicesEnabled]) {
        [_locationManager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 位置情報が更新されるたびに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.textField.text = [NSString stringWithFormat:@"%.2f m", newLocation.altitude];
}

@end
