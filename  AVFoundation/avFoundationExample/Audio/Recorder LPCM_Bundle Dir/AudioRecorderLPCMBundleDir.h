//
//  thirdRecorder.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "Filename.h"
#import "Shared.h"


typedef enum
{
    ENC_AAC = 1,
    ENC_ALAC = 2,
    ENC_IMA4 = 3,
    ENC_ILBC = 4,
    ENC_ULAW = 5,
    ENC_PCM = 6
} encodingTypes;


@interface AudioRecorderLPCMBundleDir : NSObject<AVAudioRecorderDelegate>
{
    encodingTypes recordingEncoding;
    Filename * file;
}


@property (strong, nonatomic) id<audioRecorderDelegate> delegate;
@property (strong, nonatomic) AVAudioRecorder * audioRecorder;
@property (strong, nonatomic) NSURL * recordedFileURL;


-(void)startRecording:(encodingTypes) recordingEnc;
-(void)stopRecording;

@end
