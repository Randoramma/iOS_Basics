//
//  ViewController.m
//  timers
//
//  Created by Luis Castillo on 1/17/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import "basicTimerViewController.h"

@interface basicTimerViewController ()
{
    NSTimer * timer;
    int time;
    int incrementalStartTime;
    int decrementalStartTime;
}
@end

@implementation basicTimerViewController

@synthesize startStopTimerButton, timeLabel, isCountdownTimerSwitch;


    //MARK: View Loading
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    incrementalStartTime = 0;
    decrementalStartTime = 100;
    
    [startStopTimerButton setTitle:@"START Timer" forState:UIControlStateNormal];
}//eom

    //MARK: Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//eom

    //MARK: Start / Stop Timer
- (IBAction)startStopTimer:(UIButton *)sender
{
    //start timer
    if ([sender isSelected] == false)
    {
        sender.selected = true;
    
        [self startTimer];
    
    }
    //stop timer
    else
    {
        sender.selected = false;
    
        [self stopTimer];
    }
    
    
}//eo-a

- (IBAction)countdownValueChanged:(UISwitch *)sender
{
        //  decremental
    if ([isCountdownTimerSwitch isOn] )
    {
        time = decrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
    }
    //incremental
    else
    {
        time = incrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
    }
}//eo-a

-(void)startTimer
{
    [startStopTimerButton setTitle:@"STOP Timer" forState:UIControlStateNormal];
    
    //  decremental
    if ([isCountdownTimerSwitch isOn] )
    {
        time = decrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementCounter) userInfo:nil repeats:true];
    }
    //incremental
    else
    {
        time = incrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(incrementCounter) userInfo:nil repeats:true];
    }
    

}//eom


-(void)stopTimer
{
    [startStopTimerButton setTitle:@"START Timer" forState:UIControlStateNormal];
    
    //stop timer
    [timer invalidate];
 
    //  decremental reset count
    if ( [isCountdownTimerSwitch isOn] )
    {
        time = decrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
    }
    //incremental
    else
    {
        time = incrementalStartTime;
        self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
    }
    
}//eom


-(void)incrementCounter
{
    time++;
    self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
}//eom


-(void)decrementCounter
{
    time--;
    self.timeLabel.text = [NSString stringWithFormat:@"%i", time];
    
    //stop timer
    if (time == 0)
    {
        [timer invalidate];
    }
    
}//eom


@end
