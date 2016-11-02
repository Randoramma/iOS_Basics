//
//  SegmentedControlSettings.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/25/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "SegmentedControlSettings.h"

@implementation SegmentedControlSettings

+(id)settings
{
    static id settings = nil;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}//eom

@end
