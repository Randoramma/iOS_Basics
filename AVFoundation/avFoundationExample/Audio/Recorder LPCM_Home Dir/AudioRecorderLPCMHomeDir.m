//
//  secondRecorder.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AudioRecorderLPCMHomeDir.h"
#import "Filename.h"

@implementation AudioRecorderLPCMHomeDir

@synthesize soundRecorder, delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //settings
        recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

        file = [[Filename alloc]init];
        
    }
    return self;
}

#pragma mark - Actions
-(void)startRecording
{
    //session category
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *errorFound = nil;
    [audioSession setCategory :AVAudioSessionCategoryRecord error:&errorFound];
    if(errorFound != nil){
        NSLog(@"audioSession: %@ %ld %@", [errorFound domain], (long)[errorFound code], [[errorFound userInfo] description]);
        
        [delegate audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    //session active
    [audioSession setActive:YES error:&errorFound];
    if(errorFound != nil)
    {
        NSLog(@"audioSession: %@ %ld %@", [errorFound domain], (long)[errorFound code], [[errorFound userInfo] description]);
    
        [delegate  audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    //hardware available?
    if (audioSession.isInputAvailable == false) {
        NSLog(@"No hardware available!");
        
        [delegate  audioRecorderStartFailure:@"No Hardware available"];
        return;
    }
    
    //updating file name
    recorderFilePath = [file tempfilenameOnHomeDirectoryWithCurrentDateAndExtension:@"caf"];
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    
    //set recorder
    soundRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&errorFound];
    if(errorFound != nil)
    {
        NSLog(@"recorder: %@ %ld %@", [errorFound domain], (long)[errorFound code], [[errorFound userInfo] description]);
       
        [delegate audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    //prepare to record
    [soundRecorder setDelegate:self];
    
    if ([soundRecorder prepareToRecord])
    {
        soundRecorder.meteringEnabled = YES;
        [soundRecorder record];
    }
    else
    {
       [delegate audioRecorderStartFailure:@"recorder not prepared"];
    }
    
}//eom

-(void)stopRecording
{
    [soundRecorder stop];
    self.soundRecorder = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *errorFound = nil;
  
    [audioSession setActive:NO error:&errorFound];
    if(errorFound != nil)
    {
        NSLog(@"audioSession: %@ %ld %@", [errorFound domain], (long)[errorFound code], [[errorFound userInfo] description]);
        
        [delegate audioRecorderError:errorFound];
        return;
    }
    
}//eom


#pragma mark - Delegates
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
    NSLog(@"%@", error.localizedDescription);

    [delegate audioRecorderError:error];

    NSError * errorFound = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:&errorFound];
    if(errorFound != nil)
    {
        NSLog(@"audioSession: %@ %ld %@", [errorFound domain], (long)[errorFound code], [[errorFound userInfo] description]);
    }
    
    
}//eom

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"audioRecorderDidFinishRecording");
    
    //saving file data
    NSURL * recordedURL = [[NSURL alloc ] initFileURLWithPath:recorderFilePath];
    NSData * recordedData = [[NSData alloc] initWithContentsOfURL:recordedURL];
    
    [delegate audioRecorderFinishWithData:recordedData];
    
    //removing file
    NSFileManager * fileMan = [NSFileManager defaultManager];
    NSError * errorFound = nil;
    [fileMan removeItemAtPath:recorderFilePath error:&errorFound];
    if (errorFound != nil)
    {
        NSLog(@"un-able to remove file | %@ ", errorFound .localizedDescription);
    }
    
}//eom

@end
