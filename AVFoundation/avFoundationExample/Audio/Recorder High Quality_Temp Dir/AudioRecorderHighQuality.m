//
//  highQualityRecorder.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AudioRecorderHighQuality.h"

@implementation AudioRecorderHighQuality

@synthesize soundRecorder, soundFileURL, delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Recorder settings
        recordSettings =
        [[NSDictionary alloc] initWithObjectsAndKeys:
         [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
         [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
         [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
         [NSNumber numberWithInt: AVAudioQualityMax],AVEncoderAudioQualityKey,
         nil];
        
        file = [[Filename alloc]init];
        
        
        
        //NOTE: file name/path is always the same
        //temp file name
        NSString * soundFilePath = [file tempfilenameOnTempDirectoryWithName:@"sound" andExtension:@"caf"];
        NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
        self.soundFileURL = newURL;
        
        //audio session
        NSError * audioSessionError = nil;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive: YES error: &audioSessionError];
        
        if (audioSessionError != nil) {
            NSLog(@"%@", audioSessionError.localizedDescription);
        }
        
        //audio notifications
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(audioInterruption:)
                                                     name: AVAudioSessionInterruptionNotification
                                                   object: [AVAudioSession sharedInstance]];
        
    }
    return self;
}

#pragma mark - Audio Notifications
-(void)audioInterruption:(NSNotification *)notification
{
    
}//eom



#pragma mark - Actions
-(void)stopRecording
{
    [soundRecorder stop];
    self.soundRecorder = nil;
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setActive: NO error: &audioSessionError];
    if (audioSessionError != nil)
    {
        NSLog(@"%@", audioSessionError.localizedDescription);
    }
}//eom


-(void)startRecording
{
    //audio session category
    NSError * audioSessionError = nil;
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory: AVAudioSessionCategoryRecord error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", audioSessionError.localizedDescription);
        [delegate audioRecorderStartFailure:audioSessionError.localizedDescription];
        return;
    }
    
    //audio session active
    [audioSession setActive:YES error:&audioSessionError];
    if(audioSessionError != nil)
    {
        NSLog(@"audioSession: %@ %ld %@", [audioSessionError domain], (long)[audioSessionError code], [[audioSessionError userInfo] description]);
        
        [delegate  audioRecorderStartFailure:audioSessionError.localizedDescription];
        return;
    }
    
    //hardware available?
    if (audioSession.isInputAvailable == false) {
        NSLog(@"No hardware available!");
        
        [delegate  audioRecorderStartFailure:@"No Hardware available"];
        return;
    }
    
    
    //NOTE: file name/path is always the same
    
    //record
    AVAudioRecorder *newRecorder =
    [[AVAudioRecorder alloc] initWithURL: soundFileURL
                                settings: recordSettings
                                   error: &audioSessionError];
    if (audioSessionError != nil)
    {
        NSLog(@"%@", audioSessionError.localizedDescription);
        [delegate audioRecorderStartFailure:audioSessionError.localizedDescription];
        return;
    }
    
    self.soundRecorder = newRecorder;
    
    soundRecorder.delegate = self;
    if ([soundRecorder prepareToRecord]) {
        [soundRecorder record];
    }
    else
    {
        [delegate audioRecorderStartFailure:@"recorder not prepared"];
    }
    
}//eom

#pragma mark - Delegates

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"audioRecorderDidFinishRecording");
    NSLog(@"%@", recorder.settings);
    NSLog(@"%@", recorder.format);
    
    [delegate audioRecorderFinishWithURL:self.soundFileURL];
    
    
    //NOTE: THE FILE PATH IS NOT DELETED
}//eo

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
    NSLog(@"Error: %@", error.localizedDescription);
    
    [delegate audioRecorderError:error];
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setActive: NO error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", audioSessionError.localizedDescription);
    }
}//eom

@end
