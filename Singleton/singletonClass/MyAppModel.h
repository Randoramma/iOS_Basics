//
//  AppModel.h
//  singletonClass
//
//  Created by Luis Castillo on 10/5/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAppModel : NSObject
{
    NSString * modelName;
    NSString * modelNumber;
}


-(void)updateModelName:(NSString *)name;
-(void)updateModelNumber:(NSString *)number;
-(void)debug;

+(AppModel *)sharedInstance;


@end
