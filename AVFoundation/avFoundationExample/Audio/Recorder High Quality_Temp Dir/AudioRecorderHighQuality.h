//
//  highQualityRecorder.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "Filename.h"
#import "Shared.h"

@interface AudioRecorderHighQuality : NSObject<AVAudioRecorderDelegate>
{
    NSDictionary *recordSettings ;
    Filename * file;
}


@property (strong, nonatomic) id<audioRecorderDelegate> delegate;
@property (strong, nonatomic) AVAudioRecorder * soundRecorder;
@property (strong, nonatomic) NSURL * soundFileURL;


-(void)startRecording;
-(void)stopRecording;


@end
