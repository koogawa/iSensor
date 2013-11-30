//
//  FaceDetectionViewController.m
//  iSensor
//
//  Created by koogawa on 2013/11/30.
//  Copyright (c) 2013年 Kosuke Ogawa. All rights reserved.
//

#import "FaceDetectionViewController.h"

@interface FaceDetectionViewController ()

@end

@implementation FaceDetectionViewController

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

    // インスタンス生成
    NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];

    // 画像をWebから取得
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.koogawa.com/images/jobs.jpg"]];
    UIImage *originalImage = [UIImage imageWithData:data];

    // リサイズ
    originalImage = [self resizeImage:originalImage newSize:CGSizeMake(320, 240)];
    self.imageView.image = originalImage;

    // 顔検出
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:originalImage.CGImage];
    NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CIDetectorImageOrientation];
    NSArray *array = [detector featuresInImage:ciImage options:imageOptions];

    // CoreImageは、左下の座標が (0,0) となるので、UIKitと同じ座標系に変換
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform, 0, -self.imageView.bounds.size.height);

    // 検出されたデータを取得
    for (CIFaceFeature *faceFeature in array)
    {
        // 座標変換
        const CGRect faceRect = CGRectApplyAffineTransform(faceFeature.bounds, transform);
        NSLog(@"faceFeature %@", NSStringFromCGRect(faceRect));

        // 顔検出された範囲に赤い枠線を付ける
        UIView *faceView = [[UIView alloc] initWithFrame:faceRect];
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.imageView addSubview:faceView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// イメージをリサイズする
- (UIImage *)resizeImage:(UIImage *)image newSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
