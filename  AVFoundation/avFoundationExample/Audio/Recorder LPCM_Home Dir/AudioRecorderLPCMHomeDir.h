//
//  secondRecorder.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


#import "Filename.h"
#import "Shared.h"

@interface AudioRecorderLPCMHomeDir : NSObject<AVAudioRecorderDelegate>
{
    NSMutableDictionary * recordSetting;
    NSString * recorderFilePath;
    Filename * file;
}

@property (strong, nonatomic) id<audioRecorderDelegate> delegate;
@property (strong, nonatomic) AVAudioRecorder * soundRecorder;

-(void)startRecording;
-(void)stopRecording;

@end
