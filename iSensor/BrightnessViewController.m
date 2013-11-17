//
//  BrightnessViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/17.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "BrightnessViewController.h"

@interface BrightnessViewController ()

@end

@implementation BrightnessViewController

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

    // 輝度センサー監視オン
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenBrightnessDidChange:)
                                                 name:UIScreenBrightnessDidChangeNotification
                                               object:nil];
    [self updateBrightnessLabel];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // 輝度センサー監視オフ
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIScreenBrightnessDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBrightnessLabel
{
    self.brightnessLabel.text = [NSString stringWithFormat:@"%f", [UIScreen mainScreen].brightness];
}

- (void)screenBrightnessDidChange:(NSNotification *)notification
{
    UIScreen *screen = [notification object];
    self.brightnessLabel.text = [NSString stringWithFormat:@"%f", screen.brightness];
}

- (IBAction)upButtonTapped:(id)sender
{
    double brightness = [[UIScreen mainScreen] brightness];
    brightness += 0.1;
    if (brightness > 1.0) brightness = 1.0;
    [[UIScreen mainScreen] setBrightness:brightness];
    [self updateBrightnessLabel];
}

- (IBAction)downButtonTapped:(id)sender
{
    double brightness = [[UIScreen mainScreen] brightness];
    brightness -= 0.1;
    if (brightness < 0.0) brightness = 0.0;
    [[UIScreen mainScreen] setBrightness:brightness];
    [self updateBrightnessLabel];
}

@end
