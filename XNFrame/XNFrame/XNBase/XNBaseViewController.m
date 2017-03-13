//
//  XNBasViewController.m
//  XNFrame
//
//  Created by 小鸟 on 2017/3/10.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import "XNBaseViewController.h"
#import <MBProgressHUD.h>
#import <tgmath.h>

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_8_0 1129.15
#endif

#define MBMainThreadAssert() NSAssert([NSThread isMainThread], @"MBProgressHUD needs to be accessed on the main thread.");

@interface XNBaseViewController ()

@end

@implementation XNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)modeSwitchingExample {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
////    hub.lab
//    // Set some text to show the initial status.
//    hud.labelText = NSLocalizedString(@"Preparing...", @"HUD preparing title");
//    // Will look best, if we set a minimum size.
//    hud.minSize = CGSizeMake(150.f, 100.f);
//    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        // Do something useful in the background and update the HUD periodically.
//        [self doSomeWorkWithMixedProgress];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self hideAnimated:YES];
//        });
//    });
//}

//- (void)doSomeWorkWithMixedProgress {
//    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
//    // Indeterminate mode
//    sleep(2);
//    // Switch to determinate mode
//    dispatch_async(dispatch_get_main_queue(), ^{
//        hud.mode = MBProgressHUDModeDeterminate;
//        hud.labelText = NSLocalizedString(@"Loading...", @"HUD loading title");
//    });
//    //    float progress = 0.0f;
//    //    while (progress < 1.0f) {
//    //        progress += 0.01f;
//    //        dispatch_async(dispatch_get_main_queue(), ^{
//    //            hud.progress = progress;
//    //        });
//    //        usleep(50000);
//    //    }
//    // Back to indeterminate mode
//    dispatch_async(dispatch_get_main_queue(), ^{
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.labelText = NSLocalizedString(@"Cleaning up...", @"HUD cleanining up title");
//    });
//    sleep(2);
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        hud.customView = imageView;
//        hud.mode = MBProgressHUDModeCustomView;
//        hud.labelText = NSLocalizedString(@"Completed", @"HUD completed title");
//    });
//    sleep(2);
//}

//- (void)hideAnimated:(BOOL)animated {
//    MBMainThreadAssert();
//    [self.graceTimer invalidate];
//    self.useAnimation = animated;
//    self.finished = YES;
//    // If the minShow time is set, calculate how long the HUD was shown,
//    // and postpone the hiding operation if necessary
//    if (self.minShowTime > 0.0 && self.showStarted) {
//        NSTimeInterval interv = [[NSDate date] timeIntervalSinceDate:self.showStarted];
//        if (interv < self.minShowTime) {
//            NSTimer *timer = [NSTimer timerWithTimeInterval:(self.minShowTime - interv) target:self selector:@selector(handleMinShowTimer:) userInfo:nil repeats:NO];
//            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//            self.minShowTimer = timer;
//            return;
//        }
//    }
//    // ... otherwise hide the HUD immediately
//    [self hideUsingAnimation:self.useAnimation];
//}

//- (void)showAnimated:(BOOL)animated {
//    MBMainThreadAssert();
//    [self.minShowTimer invalidate];
//    self.useAnimation = animated;
//    self.finished = NO;
//    // If the grace time is set, postpone the HUD display
//    if (self.graceTime > 0.0) {
//        NSTimer *timer = [NSTimer timerWithTimeInterval:self.graceTime target:self selector:@selector(handleGraceTimer:) userInfo:nil repeats:NO];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//        self.graceTimer = timer;
//    }
//    // ... otherwise show the HUD immediately
//    else {
//        [self showUsingAnimation:self.useAnimation];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
