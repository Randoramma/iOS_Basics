//
//  ViewController.m
//  CheckBluetoothStatus
//
//  Created by Luis Castillo on 10/17/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    BluetoothManager * btManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    btManager = [[BluetoothManager alloc]init];
    btManager.delegate = self;
    
    [btManager detectBluetooth];
}//eom


#pragma mark BluetoothManager
-(void)bluetoothStatusDidChanged:(bluetoothStatus)status
{
    //handle status here
}//eom


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
