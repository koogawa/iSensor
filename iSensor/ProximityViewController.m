//
//  ProximityViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/17.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "ProximityViewController.h"

@interface ProximityViewController ()

@end

@implementation ProximityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 近接センサオン
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;

    // 近接センサ監視
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(proximitySensorStateDidChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // 近接センサオフ
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;

    // 近接センサ監視解除
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceProximityStateDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proximitySensorStateDidChange:(NSNotification *)notification
{
    NSLog(@"%d", [UIDevice currentDevice].proximityState);
}

@end
