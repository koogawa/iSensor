//
//  LocationViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/23.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *lonTextField;

@end
