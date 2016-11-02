//
//  AppDelegate.swift
//  systemVolumeChanged
//
//  Created by Luis Castillo on 5/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupVolumeListener()
        
        return true
    }

    fileprivate func setupVolumeListener()
    {
        let frameView:CGRect = CGRect(x: -CGFloat.greatestFiniteMagnitude, y: -CGFloat.greatestFiniteMagnitude, width: 0, height: 0)
        let volumeView = MPVolumeView(frame: frameView)
        self.window?.addSubview(volumeView) //app delegate
       // self.view.addSubview(volumeView)  //view controller
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(_:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
    }//eom
    
    func volumeChanged(_ notification:Notification)
    {
        let volume = (notification as NSNotification).userInfo!["AVSystemController_AudioVolumeNotificationParameter"]
        let category = (notification as NSNotification).userInfo!["AVSystemController_AudioCategoryNotificationParameter"]
        let reason = (notification as NSNotification).userInfo!["AVSystemController_AudioVolumeChangeReasonNotificationParameter"]
        
        print("volume:      \(volume!)")
        print("category:    \(category!)")
        print("reason:      \(reason!)")
        print("\n")
    }//eom
    
    
    /*
     
     //objective-c:
     
    -(void)setupVolumeListener:(UIWindow*)window
    {
        CGRect frameview = CGRectMake(0, 0, 0, 0);
        MPVolumeView * volumeView = [[MPVolumeView alloc] initWithFrame:frameview];
        [window addSubview:volumeView]; //app delegate
        //[self.view addSubview:volumeView]; //view controller
        
        SEL selector = @selector(volumeChanged:);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    }//eom
    
    -(void)volumeChanged:(NSNotification *)notification
    {
        NSDictionary * userInfo = [notification userInfo];
        NSLog(@"volume %@", [userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]);
        NSLog(@"category %@", [userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"]);
        NSLog(@"reaosn %@", [userInfo objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"]);
        
    }//eom
    
    */
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

