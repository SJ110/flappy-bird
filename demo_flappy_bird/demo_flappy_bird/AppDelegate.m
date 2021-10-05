//
//  AppDelegate.m
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame: [UIScreen mainScreen].bounds];
    _window.rootViewController = [ViewController new];
    [_window makeKeyAndVisible];
    return YES;
}

@end
