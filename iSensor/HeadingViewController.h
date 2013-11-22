//
//  HeadingViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/22.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HeadingViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
