//
//  BluetoothStatus.m
//  CheckBluetoothStatus
//
//  Created by Luis Castillo on 10/17/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "BluetoothManager.h"

@implementation BluetoothManager
@synthesize delegate;

#pragma mark - Init
-(id)init
{
    self = [super init];
    if (self) {
        bluetoothManager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    
    return self;
}//eom


#pragma mark - Detection
- (void)detectBluetooth
{
    [self checkBluetoothState:bluetoothManager];
}//eom

-(void)checkBluetoothState:(CBCentralManager *) central
{
    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@"\nBluetooth state unknown\n");
            [delegate bluetoothStatusDidChanged:bluetooth_unknown];
            break;
        case CBManagerStateResetting:
            NSLog(@"\nThe connection with the system service was momentarily lost, update imminent.\n");
            [delegate bluetoothStatusDidChanged:bluetooth_unknown];
            break;
        case CBManagerStateUnsupported:
            NSLog(@"\nBluetooth not Supported\n");
            [delegate bluetoothStatusDidChanged:bluetooth_notSupported];
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"\nBluetooth not Authorized\n");
            [delegate bluetoothStatusDidChanged:bluetooth_unathorized];
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"\nBluetooth is OFF\n");
            [delegate bluetoothStatusDidChanged:bluetooth_off];
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"\nBluetooth is ON\n");
            [delegate bluetoothStatusDidChanged:bluetooth_on];
            break;
        default:
            break;
    }
}//eom

#pragma mark - Delegates
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [self checkBluetoothState:central];
}//eom

-(void)centralManager:(CBCentralManager *)central
 didConnectPeripheral:(CBPeripheral *)peripheral
{
    //NSLog(@"didConnectPeripheral");
}//eom


/*
 To use this method, need to do the following:
 1) update init with:
 bluetoothManager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue() options:@{ CBCentralManagerOptionRestoreIdentifierKey: @"myBluetoothIdentifier"}];
 
 2) update background mode' with "bluetooth-central"
 */
//-(void)centralManager:(CBCentralManager *)central
//     willRestoreState:(NSDictionary<NSString *,id> *)dict
//{
//    //NSLog(@"willRestoreState");
//}//eom

-(void)centralManager:(CBCentralManager *)central
didFailToConnectPeripheral:(CBPeripheral *)peripheral
                error:(NSError *)error
{
    //NSLog(@"didFailToConnectPeripheral");
}//eom

-(void)centralManager:(CBCentralManager *)central
didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                 RSSI:(NSNumber *)RSSI
{
    //NSLog(@"didDiscoverPeripheral");
}//eom

@end
