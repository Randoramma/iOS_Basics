//
//  AppDelegate.m
//  MyCoreDataStack
//
//  Created by Luis Castillo on 10/29/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AppDelegate.h"

#import "MCPersistenceController.h"

@interface AppDelegate ()

@property (strong, readwrite) MCPersistenceController *persistenceController;
- (void)completeUserInterface;

@end

@implementation AppDelegate

- (void)completeUserInterface
{
    //Application code goes here
    
    
}//eom



#pragma mark - App Delegates

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setPersistenceController:[[MCPersistenceController alloc]
                                    initWithCallback:^{
            [self completeUserInterface];
    }]];
    
    return YES;
}//eom


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [[self persistenceController] save];
}//eom


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[self persistenceController] save];
}//eom


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[self persistenceController] save];
}//eom


@end
