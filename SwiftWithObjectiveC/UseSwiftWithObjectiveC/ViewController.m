//
//  ViewController.m
//  UseSwiftWithObjectiveC
//
//  Created by Luis Castillo.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import "ViewController.h"

#import "UseSwiftWithObjectiveC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /* Calling Swift Class */
    mySwiftClass * myClass = [[mySwiftClass alloc ]init];
    myClass.desc = @"its Objective calling!";
    
    [myClass debug];
    
        //swift class uses objective-c
    [myClass callObjectiveC];
    
}//eom

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
