//
//  AppDelegate.swift
//  forceTouch
//
//  Created by Luis Castillo on 1/1/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
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

    
    
    //MARK: Force Touch
    
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        //attempt to handle shortcut item
        let handledShhortcutItem = self.handleShortcutItem(shortcutItem)
        
        //notify completion handler
        completionHandler(handledShhortcutItem)
        
    }//eom
    
    enum ShortcutIdentifier: String
    {
        case First
        case Second
        
        init?(fullType: String)
        {
            guard let last = fullType.components(separatedBy: ".").last else {return nil}
            self.init(rawValue: last)
        }
        
        var type: String
            {
                return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }//eo
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool
    {
        var handled = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        guard let shortcutType = shortcutItem.type as String? else { return false }
        
        switch (shortcutType)
        {
            case ShortcutIdentifier.First.type:
                handled = true
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "firstVC")
                self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
                
                break
            case ShortcutIdentifier.Second.type:
                handled = true
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "secondVC")
                self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
                break
            default:
                break
        }
        
        return handled
    }//eom
    
    
    /*
    remember to update your "info.plist"
    
    UIApplicationShortcutItems
    
    
    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationShortcutIcon_Class/index.html#//apple_ref/c/tdef/UIApplicationShortcutIconType
    
    
    */


}

