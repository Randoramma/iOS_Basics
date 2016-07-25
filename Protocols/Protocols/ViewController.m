//
//  ViewController.m
//  Protocols
//
//  Created by Luis Castillo on 4/7/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


//MARK: - View Loading
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myCRV = [[Cars alloc]init];
    myCRV.delegate = self;
}//eom


//MARK: - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - delegates methods
-(void)isCarReady:(BOOL)carReady
{
    if (carReady == true)
    {
        NSLog(@"Car is Ready");
    }
    else
    {
        NSLog(@"Car is NOT Ready");
    }
}//eom

//MARK: Actions
- (IBAction)startCarNow:(id)sender
{
    [myCRV StartCar];
}//eoa

@end
