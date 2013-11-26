//
//  MotionActivityViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/26.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "MotionActivityViewController.h"

@interface MotionActivityViewController ()

@end

@implementation MotionActivityViewController

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

    if (![CMStepCounter isStepCountingAvailable])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"CMStepCounter is unavailable."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
//        return;
    }

        _stepCounter = [[CMStepCounter alloc] init];
        [_stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue]
                                             updateOn:1
                                          withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                              NSLog(@"%s %ld %@ %@", __PRETTY_FUNCTION__, numberOfSteps, timestamp, error);
//                                              weakSelf.stepCountLabel.text = [@(numberOfSteps) stringValue];
                                          }];

    //if ([CMMotionActivityManager isActivityAvailable])
    {

        _activityManager = [[CMMotionActivityManager alloc] init];

        [_activityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue]
                                              withHandler:
         ^(CMMotionActivity *activity) {

             dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"activity %@", activity);

//                 NSString *status = [weakSelf statusForActivity:activity];
//                 NSString *confidence = [weakSelf stringFromConfidence:activity.confidence];
//
//                 weakSelf.statusLabel.text = [NSString stringWithFormat:@"Status: %@", status];
//                 weakSelf.confidenceLabel.text = [NSString stringWithFormat:@"Confidence: %@", confidence];
             });
         }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
