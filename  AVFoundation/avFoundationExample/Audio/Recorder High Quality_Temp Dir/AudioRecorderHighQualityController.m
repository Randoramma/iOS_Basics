//
//  ViewController.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/25/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AudioRecorderHighQualityController.h"


@interface AudioRecorderHighQualityController ()
{
    BOOL recording;
    BOOL playing;
    audioPlayer * player;
    AudioRecorderHighQuality * recorder;
}
@end

@implementation AudioRecorderHighQualityController

@synthesize recordOrStopButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    player = [[audioPlayer alloc]init];
    recorder = [[AudioRecorderHighQuality alloc]init];
    recorder.delegate = self;
    
    recording = NO;
    playing = NO;
}//eom

#pragma mark - Actions
- (IBAction) recordOrStop: (id) sender
{
    if (recording)
    {
        recording = NO;
     
        //
        [recorder stopRecording];
        
        //ui
        [recordOrStopButton setTitle: @"Record" forState:
         UIControlStateNormal];
        [recordOrStopButton setTitle: @"Record" forState:
         UIControlStateHighlighted];
    }
    else
    {
        [recorder startRecording];
        
        //UI
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateNormal];
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateHighlighted];
        
        recording = YES;
    }
}//eom

#pragma mark - Recorder delegates
-(void)audioRecorderError:(NSError *)error
{
    recording = NO;
}

-(void)audioRecorderStartFailure:(NSString *)reason
{
    recording = NO;
}


-(void)audioRecorderFinishWithURL:(NSURL *)url
{
    recording = NO;
    
    playing = YES;
    [player playAudioFromURL:url];
}//eom

#pragma mark - Player delegates
-(void)playerError:(NSError *)error
{
    playing = NO;
}//eom

-(void)playerFinish
{
    playing = NO;
}//eom

-(void)playerUnAbleToPlay
{
    playing = NO;
    NSLog(@"un-able to play audio!");
}//eom

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
