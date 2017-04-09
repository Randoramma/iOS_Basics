//
//  NewPersonViewController.h
//  CoreDataApp
//
//  Created by Luis Andres Castillo Hernandez on 9/14/15.
//  Copyright (c) 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NewPersonViewController : UIViewController<UITextFieldDelegate>


@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;


@end
