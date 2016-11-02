//
//  audioPlayer.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol audioPlayerDelegate <NSObject>

-(void)playerUnAbleToPlay;
-(void)playerFinish;
-(void)playerError:(NSError * )error;

@end

@interface audioPlayer : NSObject<AVAudioPlayerDelegate>

@property (strong, nonatomic) id<audioPlayerDelegate> delegate;
@property (strong, nonatomic) AVAudioPlayer * audio_player;


-(void)playAudioFromURL:(NSURL *) url;
-(void)playAudioFromData:(NSData *) data;


@end
