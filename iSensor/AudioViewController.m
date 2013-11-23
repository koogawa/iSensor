//
//  AudioViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/23.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "AudioViewController.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

static void AudioInputCallback(
                               void* inUserData,
                               AudioQueueRef inAQ,
                               AudioQueueBufferRef inBuffer,
                               const AudioTimeStamp *inStartTime,
                               UInt32 inNumberPacketDescriptions,
                               const AudioStreamPacketDescription *inPacketDescs)
{
    // 録音はしないので未実装
}

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

    // 音を拾う
    [self startUpdatingVolume];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    // レベルの監視を停止する
    [_timer invalidate];
    [self stopUpdatingVolume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startUpdatingVolume
{
    // 記録するデータフォーマットを決める
    AudioStreamBasicDescription dataFormat;
    dataFormat.mSampleRate = 44100.0f;
    dataFormat.mFormatID = kAudioFormatLinearPCM;
    dataFormat.mFormatFlags = kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    dataFormat.mBytesPerPacket = 2;
    dataFormat.mFramesPerPacket = 1;
    dataFormat.mBytesPerFrame = 2;
    dataFormat.mChannelsPerFrame = 1;
    dataFormat.mBitsPerChannel = 16;
    dataFormat.mReserved = 0;

    // レベルの監視を開始する
    AudioQueueNewInput(&dataFormat, AudioInputCallback, (__bridge void *)(self), CFRunLoopGetCurrent(), kCFRunLoopCommonModes, 0, &_queue);
    AudioQueueStart(_queue, NULL);

    // レベルメータを有効化する
    UInt32 enabledLevelMeter = true;
    AudioQueueSetProperty(_queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, sizeof(UInt32));

    // 定期的にレベルメータを監視する
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(detectVolume:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)stopUpdatingVolume
{
    // キューを空にして停止
    AudioQueueFlush(_queue);
    AudioQueueStop(_queue, NO);
    AudioQueueDispose(_queue, YES);
}

- (void)detectVolume:(NSTimer *)timer
{
    // レベルを取得
    AudioQueueLevelMeterState levelMeter;
    UInt32 levelMeterSize = sizeof(AudioQueueLevelMeterState);
    AudioQueueGetProperty(_queue, kAudioQueueProperty_CurrentLevelMeterDB, &levelMeter, &levelMeterSize);

    // 最大レベル、平均レベルを表示
    self.peakTextField.text = [NSString stringWithFormat:@"%.2f", levelMeter.mPeakPower];
    self.averageTextField.text = [NSString stringWithFormat:@"%.2f", levelMeter.mAveragePower];

    // mPeakPowerが -1.0 以上なら "LOUD!!" と表示
    self.loudLabel.hidden = (levelMeter.mPeakPower >= -1.0f) ? NO : YES;
}

@end
