//
//  MCPersistenceController.h
//  MyCoreDataStack
//
//  Created by Luis Castillo on 10/29/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^InitCallbackBlock)(void);

@interface MCPersistenceController : NSObject


@property (strong, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithCallback:(InitCallbackBlock)callback;
- (void)save;


@end
