//
//  ShareSetting.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ShareSetting.h"

@implementation ShareSetting

+ (id)sharedSettings
{
    static id shareSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSettings = [[self alloc] init];
    });
    return shareSettings;
}

@end
