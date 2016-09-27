//
//  ViewController.m
//  OSVersion
//
//  Created by Luis Castillo on 9/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //objective-c
    [self checkOSVersion];
    
    //swift
    [[[CheckOSOversion alloc]init] checkVersion];
}//eom

-(void)checkOSVersion
{
    NSString * osVersionString = [[NSProcessInfo processInfo] operatingSystemVersionString];
    
    NSOperatingSystemVersion osVersion = [[NSProcessInfo processInfo]operatingSystemVersion];
    
    NSInteger maxVersion = osVersion.majorVersion;
    NSInteger minVersion = osVersion.minorVersion;
    
    NSString * printString = @"Objective-c \n";
    printString = [printString stringByAppendingFormat:@" OS (Max.Min) = %ld . %ld  \n" ,(long)maxVersion, (long)minVersion];
    printString = [printString stringByAppendingString:osVersionString];
    
    NSLog(@"%@ \n\n", printString);
}//eom

@end
