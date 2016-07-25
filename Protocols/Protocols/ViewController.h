//
//  ViewController.h
//  Protocols
//
//  Created by Luis Castillo on 4/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cars.h"


@interface ViewController : UIViewController<carDelegate>
{
    Cars * myCRV;
    
}

@end

