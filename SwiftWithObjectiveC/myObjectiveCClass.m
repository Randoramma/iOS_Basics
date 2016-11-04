//
//  myObjectiveCClass.m
//  UseSwiftWithObjectiveC
//
//  Created by Luis Castillo
//  Copyright © 2016 DevBros. All rights reserved.
//

#import "myObjectiveCClass.h"

@implementation myObjectiveCClass

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bookTitle = @"Half Blood Prince";
    }
    return self;
}



-(void)debug
{
    NSLog(@"booktitle: %@",self.bookTitle);
}//eom
@end
