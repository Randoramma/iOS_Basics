//
//  ShareSetting.h
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareSetting : NSObject

@property (nonatomic) BOOL menuTapped;
@property (nonatomic) BOOL profileTapped;
+ (id)sharedSettings;

@end
