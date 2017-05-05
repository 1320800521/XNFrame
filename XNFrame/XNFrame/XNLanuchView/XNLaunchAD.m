


//
//  XNLaunchAD.m
//  XNLaunchAD
//
//  Created by 小鸟 on 2017/3/15.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNLaunchAD.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
//#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "XNLunchDown.h"



#define KADWIDTH 100    // 广告时间、跳过按钮宽度

#define KADHIGHT 30     // 广告时间、跳过高度

#define KADTIME 5       // 广告时间

@interface XNLaunchAD ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) AVPlayerViewController *myPlayer;

@property (nonatomic,strong) UILabel *adTimeLabel;

@property (nonatomic,strong) UIButton *jeepBtn;

@end

static UIWindow *XN_window;

static UIImageView *XN_imageView;

static XNLaunchAD * XN_Launch = nil;

@implementation XNLaunchAD


+ (instancetype)shareInstLanuchAD{
    

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        XN_Launch = [[XNLaunchAD alloc]init];
    });
    return XN_Launch;
}

+ (UIImageView *)XN_imageView{
    
    if (!XN_imageView) {
        XN_imageView = [[UIImageView alloc]init];
    }
    
    return XN_imageView;
}

+ (UIWindow *)XN_window{
    
    if (!XN_window) {
        XN_window = [UIApplication sharedApplication].keyWindow;
    }
    return XN_window;
}

/**
 添加本地图片广告
 */
- (void)addGifIMgADD{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];

    self.imageView.animationImages = [self animationImages];
    
//    self.imageView.image = [[self animationImages] objectAtIndex:0];
    self.imageView.animationDuration = 4;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];
    
    
    [window addSubview:self.imageView];
    
    // 广告时间显示
    self.adTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(window.frame.size.width - KADWIDTH, 30, 150, 30)];
    self.adTimeLabel.backgroundColor = [UIColor clearColor];
    
    self.adTimeLabel.text = [NSString stringWithFormat:@"%d",KADTIME];
    
    [window addSubview:self.adTimeLabel];
    
    // 跳过按钮
    self.jeepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jeepBtn.frame = CGRectMake(window.frame.size.width - KADWIDTH, window.frame.size.height - KADHIGHT, KADWIDTH, KADHIGHT);
    [self.jeepBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.jeepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.jeepBtn addTarget:self action:@selector(jeepBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:self.jeepBtn];
    
    [self openCountdown];
    
}


/**
 加载Gif

 @return gif图片数组
 */
- (NSArray *)animationImages
{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"image12" withExtension:@"gif"];
    NSDictionary *dic = [self getGifInfo:fileUrl];
    
    NSArray *arrays = dic[@"images"];
    
    return arrays;
}


- (NSDictionary *)getGifInfo:(NSURL *)fileURL
{
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *delays = [NSMutableArray arrayWithCapacity:3];
    NSUInteger loopCount = 0;
    CGFloat totalTime;         // seconds
    CGFloat width;
    CGFloat height;
    
    getFrameInfo((__bridge CFURLRef)fileURL, frames, delays, &totalTime, &width, &height, loopCount);
    NSDictionary *gifDic = @{@"images":frames,          //图片数组
                             @"delays":delays,          //每一帧对应的延迟时间数组
                             @"duration":@(totalTime),  //GIF图播放一遍的总时间
                             @"loopCount":@(loopCount), //GIF图播放次数  0-无限播放
                             @"bounds": NSStringFromCGRect(CGRectMake(0, 0, width, height))}; //GIF图的宽高
    return gifDic;
}

- (void)jeepBtnClick:(UIButton *)btn{
    
    [self.adTimeLabel removeFromSuperview];
    
    [self.imageView removeFromSuperview];
    
    [self.myPlayer.view removeFromSuperview];
}

/**
 计时器 记录广告展示时间
 
 */
- (void)openCountdown{
    
    __block NSInteger time = KADTIME; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.adTimeLabel removeFromSuperview];
                [self.imageView removeFromSuperview];
                [self.jeepBtn removeFromSuperview];
                [self.myPlayer.view removeFromSuperview];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                self.adTimeLabel.text = [NSString stringWithFormat:@"%d秒后关闭", seconds];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

/*
 * @brief resolving gif information
 */
void getFrameInfo(CFURLRef url, NSMutableArray *frames, NSMutableArray *delayTimes, CGFloat *totalTime,CGFloat *gifWidth, CGFloat *gifHeight,NSUInteger loopCount)
{
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL(url, NULL);
    
    //获取gif的帧数
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    //获取GfiImage的基本数据
    NSDictionary *gifProperties = (__bridge NSDictionary *) CGImageSourceCopyProperties(gifSource, NULL);
    //由GfiImage的基本数据获取gif数据
    NSDictionary *gifDictionary =[gifProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary];
    //获取gif的播放次数 0-无限播放
    loopCount = [[gifDictionary objectForKey:(NSString*)kCGImagePropertyGIFLoopCount] integerValue];
    CFRelease((__bridge CFTypeRef)(gifProperties));
    
    for (size_t i = 0; i < frameCount; ++i) {
        //得到每一帧的CGImage
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:[UIImage imageWithCGImage:frame]];
        CGImageRelease(frame);
        
        //获取每一帧的图片信息
        NSDictionary *frameDict = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        
        //获取Gif图片尺寸
        if (gifWidth != NULL && gifHeight != NULL) {
            *gifWidth = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
            *gifHeight = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        }
        
        //由每一帧的图片信息获取gif信息
        NSDictionary *gifDict = [frameDict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        //取出每一帧的delaytime
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        if (totalTime) {
            *totalTime = *totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
        }
        CFRelease((__bridge CFTypeRef)(frameDict));
    }
    CFRelease(gifSource);
}


- (void)addVideoLanuch:(NSString *)path{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSURL *urlstr = [NSURL URLWithString:path];
    if (!path) {
        urlstr = [[NSBundle mainBundle]URLForResource:@"video1" withExtension:@"mp4"];
    }
    
    self.myPlayer = [[AVPlayerViewController alloc]init];
    self.myPlayer.view.frame = window.bounds;
    self.myPlayer.showsPlaybackControls = NO;
    self.myPlayer.player = [[AVPlayer alloc]initWithURL:urlstr];
    self.myPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.myPlayer.player play];
    
    [window addSubview:self.myPlayer.view];
    
    
    // 广告时间显示
    self.adTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(window.frame.size.width - KADWIDTH, 30, 150, 30)];
    self.adTimeLabel.backgroundColor = [UIColor clearColor];
    
    self.adTimeLabel.text = [NSString stringWithFormat:@"%d",KADTIME];
    
    [window addSubview:self.adTimeLabel];
    
    // 跳过按钮
    self.jeepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jeepBtn.frame = CGRectMake(window.frame.size.width - KADWIDTH, window.frame.size.height - KADHIGHT, KADWIDTH, KADHIGHT);
    [self.jeepBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.jeepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.jeepBtn addTarget:self action:@selector(jeepBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:self.jeepBtn];
    
    [self openCountdown];
    
}



- (void)downloadAD:(NSString *)urlStr{

    [self addVideoLanuch:[[NSUserDefaults standardUserDefaults]objectForKey:@"savepath"]];
//    if (![urlStr isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"url"]]) {
//        [XNLunchDown downLoadADwithDownloadPath:urlStr downLoadBlock:^(NSString *path) {
//            if (path) {
//                [self addVideoLanuch:path];
//            }
//        }];
//    }
    
}

@end
