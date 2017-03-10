//
//  AppDelegate.h
//  XNFrame
//
//  Created by 小鸟 on 2017/3/9.
//  Copyright © 2017年 小鸟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

