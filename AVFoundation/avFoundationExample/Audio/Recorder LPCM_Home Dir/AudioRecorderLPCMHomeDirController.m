//
//  TwoViewController.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AudioRecorderLPCMHomeDirController.h"


@interface AudioRecorderLPCMHomeDirController ()
{
    BOOL recording;
    BOOL playing;
    audioPlayer * player;
    AudioRecorderLPCMHomeDir * recorder;
    NSData * recordedFileData;
}
@end

@implementation AudioRecorderLPCMHomeDirController

@synthesize recordOrStopButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    player = [[audioPlayer alloc]init];
    player.delegate = self;
    
    recorder = [[AudioRecorderLPCMHomeDir alloc]init];
    recorder.delegate = self;
    
    
}//eom



#pragma mark - Actions
- (IBAction) recordOrStop: (id) sender
{
 
    if (recording) {
        
        recording = NO;
        
        //stoping recorder
        [recorder stopRecording];
        
        [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
        [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
    }
    else
    {
        //start recording
        [recorder startRecording];
        
        [recordOrStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [recordOrStopButton setTitle:@"Stop" forState:UIControlStateHighlighted];
        
        recording = YES;
    }
}//eo-a



#pragma mark - Player delegates
-(void)playerError:(NSError *)error
{
    playing = NO;
    
    
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
}//eom

-(void)playerFinish
{
    playing = NO;
    
    
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
}//eom

-(void)playerUnAbleToPlay
{
    playing = NO;
    NSLog(@"un-able to play audio!");
    
    
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
}//eom


#pragma mark - Recorder delegates
-(void)audioRecorderFinishWithData:(NSData *)filedata
{
    recording = NO;
    
    playing = YES;
    self->recordedFileData = filedata;
    [player playAudioFromData:self->recordedFileData];
}//eom

-(void)audioRecorderError:(NSError *)error
{
    recording = NO;
    
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
}//eom

-(void)audioRecorderStartFailure:(NSString *)reason
{
    recording = NO;
    
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordOrStopButton setTitle:@"Record" forState:UIControlStateHighlighted];
}//eom


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
