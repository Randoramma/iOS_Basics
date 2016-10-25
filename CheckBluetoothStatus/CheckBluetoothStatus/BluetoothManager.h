//
//  BluetoothStatus.h
//  CheckBluetoothStatus
//
//  Created by Luis Castillo on 10/17/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

typedef enum {
    bluetooth_unknown,
    bluetooth_notSupported,
    bluetooth_unathorized,
    bluetooth_off,
    bluetooth_on
} bluetoothStatus;

@protocol bluetoothManagerDelegate <NSObject>

-(void)bluetoothStatusDidChanged:(bluetoothStatus)status;

@end


@interface BluetoothManager : NSObject<CBCentralManagerDelegate>
{
    CBCentralManager * bluetoothManager;
}

@property (nonatomic) id<bluetoothManagerDelegate> delegate;


- (void)detectBluetooth;

@end
