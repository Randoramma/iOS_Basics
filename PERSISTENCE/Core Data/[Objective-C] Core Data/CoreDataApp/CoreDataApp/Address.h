//
//  Address.h
//  CoreDataApp
//
//  Created by Luis Andres Castillo Hernandez on 9/14/15.
//  Copyright (c) 2015 DevBros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) Person *person;

@end
