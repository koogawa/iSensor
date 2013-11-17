//
//  BrightnessViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/17.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrightnessViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;

- (IBAction)upButtonTapped:(id)sender;
- (IBAction)downButtonTapped:(id)sender;

@end
