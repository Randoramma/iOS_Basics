//
//  audioPlayer.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "audioPlayer.h"

@implementation audioPlayer

@synthesize audio_player, delegate;



-(void)playAudioFromData:(NSData *) data
{
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", [audioSessionError localizedDescription]);
    }
    
    NSError * audioError;
    AVAudioPlayer * newPlayer = [[AVAudioPlayer alloc] initWithData:data error:&audioError];

    if (audioError != nil) {
        NSLog(@"%@", [audioError localizedDescription]);
    }
    
    self.audio_player = newPlayer;
    
    [audio_player prepareToPlay];
    [audio_player setDelegate:self];
    if (audio_player .prepareToPlay)
    {
        [self.audio_player play];
    }
    else
    {
        [delegate playerUnAbleToPlay];
    }
}//eom

-(void)playAudioFromURL:(NSURL *) url
{
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", [audioSessionError localizedDescription]);
    }
    
    NSError * audioError;
    AVAudioPlayer * newPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&audioError];
    
    if (audioError != nil) {
        NSLog(@"%@", [audioError localizedDescription]);
    }
    
    self.audio_player = newPlayer;
    
    [audio_player prepareToPlay];
    [audio_player setDelegate:self];
    if (audio_player .prepareToPlay)
    {
        [self.audio_player play];
    }
    else
    {
        [delegate playerUnAbleToPlay];
    }
}//eom


#pragma mark player delegates
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"audioPlayerDecodeErrorDidOccur");
    NSLog(@"error: %@", error.localizedDescription);
    [delegate playerError:error];
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setActive: NO error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", audioSessionError.localizedDescription);
    }
}//eom

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"\n\naudioPlayerDidFinishPlaying");
    
    NSLog(@"%@", player.settings);
    NSLog(@"%@", player.format);
    
    [delegate playerFinish];
    
    NSError * audioSessionError = nil;
    [[AVAudioSession sharedInstance] setActive: NO error: &audioSessionError];
    if (audioSessionError != nil) {
        NSLog(@"%@", audioSessionError.localizedDescription);
    }
}//eom

@end
