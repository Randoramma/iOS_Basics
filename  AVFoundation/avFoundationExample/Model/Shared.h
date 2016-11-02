//
//  Shared.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol audioRecorderDelegate <NSObject>

@required
-(void)audioRecorderStartFailure:(NSString *) reason;
-(void)audioRecorderError:(NSError * )error;

@optional
-(void)audioRecorderFinishWithData:(NSData *)filedata;
-(void)audioRecorderFinishWithURL:(NSURL *)fileUrl;

@end

