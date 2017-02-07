//
//  Filename.m
//  audioRecorder
//
//  Created by Luis Castillo on 10/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "Filename.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@implementation Filename


#pragma mark - TEMP directory
-(NSString *)tempfilenameOnTempDirectoryWithName:(NSString *)name andExtension:(NSString *) extension
{
    NSString *tempDir = NSTemporaryDirectory ();
    NSString *tempFilePath =  [tempDir stringByAppendingFormat:@"%@.%@",name, extension];
    
    return tempFilePath;

}//eom


#pragma mark - MAINBUNDLE/RESOURCE directory
-(NSString *)tempfilenameOnMainBundleResourcePathWithName:(NSString *)name andExtension:(NSString *) extension
{
    NSString * resourcePath = [NSBundle mainBundle] .resourcePath;
    NSString * tempfilename = [resourcePath stringByAppendingFormat:@"/%@.%@", name, extension];
    
    return  tempfilename;
}//eom

#pragma mark - HOME directory

-(NSString *)tempfilenameOnHomeDirectoryWithCurrentDateAndExtension:(NSString *) extension
{
    NSDate *now = [NSDate date];
    NSString *calDate = [now description];\
    NSString * tempFileName = [NSString stringWithFormat:@"%@/%@", DOCUMENTS_FOLDER, calDate];
    tempFileName = [tempFileName stringByAppendingFormat:@".%@", extension];
    
    /*
     /var/mobile/Containers/Data/Application/B4951E91-3068-4CEC-AFE6-68879601764F/Documents/2016-10-26 20:24:16 +0000.caf
     */
    
    return tempFileName;
}//eom

@end
