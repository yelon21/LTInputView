//
//  LYAppDelegate.m
//  LTInputView
//
//  Created by yelon21 on 07/15/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYAppDelegate.h"

@implementation LYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    if (@available(iOS 11.0, *)) {
        
        BOOL isCaptured = [mainScreen isCaptured];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(screenCapturedDidChangeNotification:)
                                                     name:UIScreenCapturedDidChangeNotification
                                                   object:nil];
    } else {
        // Fallback on earlier versions
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenCapturedDidChangeNotification:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];

    return YES;
}

- (void)screenCapturedDidChangeNotification:(NSNotification *)notification{
    
    NSLog(@"notification=%@",notification);
    
    if ([notification.name isEqualToString:UIScreenCapturedDidChangeNotification]) {
        
        UIScreen *screen = [notification object];
        NSLog(@"captured=%@",@(screen.isCaptured));
        NSLog(@"captured=%@",UIScreen.screens);
    }
    else if ([notification.name isEqualToString:UIApplicationUserDidTakeScreenshotNotification]) {
        
        UIApplication *application = [notification object];
        [self.window endEditing:YES];
    }
    
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
