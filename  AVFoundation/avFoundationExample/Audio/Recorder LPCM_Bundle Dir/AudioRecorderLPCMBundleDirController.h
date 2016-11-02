//
//  thirdViewController.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Shared.h"
#import "audioPlayer.h"
#import "AudioRecorderLPCMBundleDir.h"

@interface AudioRecorderLPCMBundleDirController : UIViewController<audioRecorderDelegate, audioPlayerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *recordOrStopButton;


@end
