//
//  AppDelegate.h
//  MyCoreDataStack
//
//  Created by Luis Castillo on 10/29/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCPersistenceController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) MCPersistenceController *persistenceController;

@end

