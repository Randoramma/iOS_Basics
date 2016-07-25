//
//  Cars.m
//  Protocols
//
//  Created by Luis Castillo on 4/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "Cars.h"

@implementation Cars

@synthesize  delegate;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void)StartCar
{
    [delegate isCarReady:TRUE];
}//eom


@end
