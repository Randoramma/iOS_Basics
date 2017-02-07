//
//  TwoViewController.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "audioPlayer.h"
#import "AudioRecorderLPCMHomeDir.h"
#import "Shared.h"

@interface AudioRecorderLPCMHomeDirController : UIViewController<audioPlayerDelegate, audioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *recordOrStopButton;



@end
