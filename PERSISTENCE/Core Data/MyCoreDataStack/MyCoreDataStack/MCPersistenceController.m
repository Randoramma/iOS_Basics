//
//  MCPersistenceController.m
//  MyCoreDataStack
//
//  Created by Luis Castillo on 10/29/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "MCPersistenceController.h"


@interface MCPersistenceController()

@property (strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong) NSManagedObjectContext *privateContext;
@property (copy) InitCallbackBlock initCallback;

- (void)initializeCoreData;

@end

@implementation MCPersistenceController

- (id)initWithCallback:(InitCallbackBlock)callback;
{
    if (!(self = [super init])) return nil;
    
    [self setInitCallback:callback];
    [self initializeCoreData];
    
    return self;
}

- (void)initializeCoreData
{
    if ([self managedObjectContext]) return;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc]
                                 initWithContentsOfURL:modelURL];
     NSAssert(mom,
              @"%@:%@ No model to generate a store from",
              [self class],
              NSStringFromSelector(_cmd));
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]
                                                 initWithManagedObjectModel:mom];
    NSAssert(coordinator, @"Failed to initialize coordinator");
    
    //main object context - single source of truth
    [self setManagedObjectContext:[[NSManagedObjectContext alloc]
                                   initWithConcurrencyType:NSMainQueueConcurrencyType]];
    
    [self setPrivateContext:[[NSManagedObjectContext alloc]
                             initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
    [[self privateContext] setPersistentStoreCoordinator:coordinator];
    [[self managedObjectContext] setParentContext:[self privateContext]];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSPersistentStoreCoordinator *psc = [[self privateContext] persistentStoreCoordinator];
        
        //options
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
        options[NSInferMappingModelAutomaticallyOption] = @YES;
        options[NSSQLitePragmasOption] = @{ @"journal_mode":@"DELETE" };
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
        
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
        
        NSError *error = nil;
        
        //persistent store setup
        NSAssert([psc addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil URL:storeURL
                                         options:options error:&error],
             @"Error initializing PSC: %@\n%@",
                 [error localizedDescription],
                 [error userInfo]);
        
        if (![self initCallback]) return;
        
        //notifying UI model is ready
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self initCallback]();
        });//eo-main queue
    });//eo-queue
    
}//eom
    


- (void)save;
{
    if (![[self privateContext] hasChanges] && ![[self managedObjectContext] hasChanges]) return;
    
    [[self managedObjectContext] performBlockAndWait:^{
        NSError *error = nil;
        
        NSAssert([[self managedObjectContext] save:&error],
                 @"Failed to save main context: %@\n%@",
                 [error localizedDescription],
                 [error userInfo]);
        
        [[self privateContext] performBlock:^{
            NSError *privateError = nil;
            NSAssert([[self privateContext] save:&privateError],
                     @"Error saving private context: %@\n%@",
                     [privateError localizedDescription],
                     [privateError userInfo]);
        }];
    }];
}//eom

@end
