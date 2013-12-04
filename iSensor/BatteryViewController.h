//
//  BatteryViewController.h
//  iSensor
//
//  Created by koogawa on 2013/12/04.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BatteryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *batteryLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryStateLabel;

@end
