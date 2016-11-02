//
//  AppModel.m
//  singletonClass
//
//  Created by Luis Castillo on 10/5/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "MyAppModel.h"

@implementation MyAppModel

+(MyAppModel *)sharedInstance
{
    static MyAppModel * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}//eom


-(void)updateModelName:(NSString *)name
{
    modelName = name;
}//eom


-(void)updateModelNumber:(NSString *)number
{
    modelNumber = number;
}//eom

-(void)debug
{
    NSLog(@"\n\n");
    NSLog(@"Model Name: %@", modelName);
    NSLog(@"Model Number: %@", modelNumber);
    NSLog(@"\n\n");
}//eom


@end
