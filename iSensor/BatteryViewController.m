//
//  BatteryViewController.m
//  iSensor
//
//  Created by koogawa on 2013/12/04.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "BatteryViewController.h"

@interface BatteryViewController ()

@end

@implementation BatteryViewController

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

    // バッテリー状態を監視できるようにする
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;

    // バッテリー残量監視オン
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryLevelDidChange:)
                                                 name:UIDeviceBatteryLevelDidChangeNotification
                                               object:nil];
    [self updateBatteryLevelLabel];

    // バッテリー充電状態監視オン
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryStateDidChange:)
                                                 name:UIDeviceBatteryStateDidChangeNotification
                                               object:nil];

    [self updateBatteryStateLabel];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // バッテリー状態の監視を完了
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;

    // バッテリー残量監視オフ
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceBatteryLevelDidChangeNotification
                                                  object:nil];
    // バッテリー充電状態監視オフ
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceBatteryStateDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

- (void)updateBatteryLevelLabel
{
    // バッテリーの残量を取得する
    float batteryLevel = [UIDevice currentDevice].batteryLevel;

    self.batteryLevelLabel.text = [NSString stringWithFormat:@"%f", batteryLevel];
}

- (void)updateBatteryStateLabel
{
    NSString *batteryStateString;

    // バッテリーの充電状態を取得する
    switch ([UIDevice currentDevice].batteryState)
    {
        case UIDeviceBatteryStateFull:
            batteryStateString = @"Full";
            break;

        case UIDeviceBatteryStateUnplugged:
            batteryStateString = @"Unplugged";
            break;

        case UIDeviceBatteryStateCharging:
            batteryStateString = @"Charging";
            break;

        case UIDeviceBatteryStateUnknown:
            batteryStateString = @"Unknown";
            break;

        default:
            break;
    }

    self.batteryStateLabel.text = batteryStateString;
}

- (void)batteryLevelDidChange:(NSNotification *)notification
{
    [self updateBatteryLevelLabel];
}

- (void)batteryStateDidChange:(NSNotification *)notification
{
    [self updateBatteryStateLabel];
}

@end
