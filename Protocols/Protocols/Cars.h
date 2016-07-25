//
//  Cars.h
//  Protocols
//
//  Created by Luis Castillo on 4/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol carDelegate <NSObject>

-(void)isCarReady:(BOOL) carReady;

@end

@interface Cars : NSObject

@property (nonatomic, weak) id<carDelegate>delegate;




-(void)StartCar;

@end
