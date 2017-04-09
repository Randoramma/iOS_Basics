//
//  PersonsTableViewController.h
//  CoreDataApp
//
//  Created by Luis Andres Castillo Hernandez on 9/14/15.
//  Copyright (c) 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonsTableViewController : UITableViewController


@property(strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@end
