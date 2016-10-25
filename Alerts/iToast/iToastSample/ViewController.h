//
//  ViewController.h
//  iToastSample
//
//  Created by Luis Castillo on 9/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iToast.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *messageToDisplayLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *durationSegmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *locationSegmentedControl;


@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmentedControl;


@property (weak, nonatomic) IBOutlet UIButton *showToastButton;

@end

