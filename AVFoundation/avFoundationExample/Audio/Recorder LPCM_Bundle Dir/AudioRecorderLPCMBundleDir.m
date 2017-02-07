//
//  thirdRecorder.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "AudioRecorderLPCMBundleDir.h"

@implementation AudioRecorderLPCMBundleDir

@synthesize audioRecorder, delegate, recordedFileURL;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        recordingEncoding = ENC_AAC;
        
        file = [[Filename alloc]init];
    }
    return self;
}


#pragma mark - actions
-(void)startRecording:(encodingTypes) recordingEnc
{
    recordingEncoding = recordingEnc;
    
    NSError * errorFound = nil;
    
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    
    //session category
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&errorFound];
    if (errorFound != nil) {
        NSLog(@"%@", errorFound.localizedDescription);
        
        [delegate audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    
    //session activate
    [audioSession setActive:YES error:&errorFound];
    if (errorFound != nil) {
        NSLog(@"%@", errorFound.localizedDescription);
        
        [delegate audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    //settings
    NSMutableDictionary * recordSettings = [[NSMutableDictionary alloc]initWithCapacity:10];
    if (recordingEnc == ENC_PCM)
    {
        [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    }
    else
    {
        NSNumber *formatObject;
        
        switch (recordingEncoding) {
            case (ENC_AAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                break;
            case (ENC_ALAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                break;
            case (ENC_IMA4):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                break;
            case (ENC_ILBC):
                formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                break;
            case (ENC_ULAW):
                formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                break;
            default:
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
        }
        
        [recordSettings setObject:formatObject forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
    }
    
    //temp file
    NSString * recorderFilePath = [file tempfilenameOnMainBundleResourcePathWithName:@"recordTest" andExtension:@"caf"];
    recordedFileURL = [[NSURL alloc]initFileURLWithPath:recorderFilePath];
    
    //recording
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:recordedFileURL settings:recordSettings error:&error];
    if(error != nil)
    {
        NSLog(@"recorder: %@", error.localizedDescription);
        
        [delegate audioRecorderStartFailure:errorFound.localizedDescription];
        return;
    }
    
    
    [audioRecorder setDelegate:self];
    
    if ([audioRecorder prepareToRecord])
    {
        [audioRecorder record];
    }
    else
    {
        [delegate audioRecorderStartFailure:@"un-able to start"];
        return;
    }
}//eom

-(void)stopRecording
{
    [audioRecorder stop];
    
    NSError * errorFound = nil;
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:&errorFound];
    
    if (errorFound != nil) {
        NSLog(@"%@", errorFound.localizedDescription);
    }
}//eom

#pragma mark - delegates
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
     NSLog(@"error: %@", error.localizedDescription);
    
    [delegate audioRecorderError:error];
    
    NSError * errorFound = nil;
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:&errorFound];
    
    if (errorFound != nil) {
        NSLog(@"%@", errorFound.localizedDescription);
    }
}//eom

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"audioRecorderDidFinishRecording");
    
    //saving file data
    NSData * recordedData = [[NSData alloc] initWithContentsOfURL:recordedFileURL];
    
    [delegate audioRecorderFinishWithData:recordedData];
    
}//eom


@end
