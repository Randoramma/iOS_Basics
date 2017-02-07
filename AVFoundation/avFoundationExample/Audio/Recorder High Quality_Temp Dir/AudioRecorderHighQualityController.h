//
//  ViewController.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/25/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "audioPlayer.h"
#import "AudioRecorderHighQuality.h"
#import "Shared.h"


@interface AudioRecorderHighQualityController : UIViewController<audioRecorderDelegate, audioPlayerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *recordOrStopButton;


@end

