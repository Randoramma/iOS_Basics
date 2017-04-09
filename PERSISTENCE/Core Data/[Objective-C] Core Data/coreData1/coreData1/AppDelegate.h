//
//  AppDelegate.h
//  coreData1
//
//  Created by Luis Andres Castillo Hernandez on 9/22/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//manages object
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//generic class for object model
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

//looks for objects to find what we need
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

