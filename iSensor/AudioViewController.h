//
//  AudioViewController.h
//  iSensor
//
//  Created by koogawa on 2013/11/23.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioViewController : UIViewController
{
    AudioQueueRef   _queue;     // 音声入力用のキュー
    NSTimer         *_timer;    // 監視タイマー
}

@property (weak, nonatomic) IBOutlet UILabel *loudLabel;
@property (weak, nonatomic) IBOutlet UITextField *peakTextField;
@property (weak, nonatomic) IBOutlet UITextField *averageTextField;

@end
