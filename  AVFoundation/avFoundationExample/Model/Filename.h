//
//  Filename.h
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filename : NSObject


#pragma mark TEMP
-(NSString *)tempfilenameOnTempDirectoryWithName:(NSString *)name andExtension:(NSString *) extension;


#pragma mark MAINBUNDLE
-(NSString *)tempfilenameOnMainBundleResourcePathWithName:(NSString *)name andExtension:(NSString *) extension;

#pragma mark HOME
-(NSString *)tempfilenameOnHomeDirectoryWithCurrentDateAndExtension:(NSString *)extension;


@end
