//
//  ViewController.h
//  timers
//
//  Created by Luis Castillo on 1/17/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface basicTimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *isCountdownTimerSwitch;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *startStopTimerButton;
- (IBAction)startStopTimer:(UIButton *)sender;

- (IBAction)countdownValueChanged:(UISwitch *)sender;
@end

