//
//  PROGRAMMER: Luis Castillo
//  PANTHERID: 3607503
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     Par,cipa,on Assignment #3
//  DUE:            Thursday 10/13/15
//  DESC:
//     Modify the Accelerometer code to move the UIBu^on in the direc,on of the iPad is ,lted in.
//     •  The bu^on should wrap around each edge of the screen so as it moves off screen it appears on the other side.
//     •  Implement a filter to reduce movement jitter.

//
//  Accel1ViewController.h
//  Accel1
//
//  Created by Steven Luis on 10/28/11.
//  Copyright 2011 FIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Accel1ViewController : UIViewController <UIAccelerometerDelegate> {
    
    UIButton *movingButtonOutlet;
    
    NSArray *progressBar;
    NSArray *labelValues;
    CGFloat screenHeight;
    CGFloat screenWidth;

}


- (void) viewWillAppear: (BOOL) animated;

- (void) viewDidDisappear:(BOOL) animated;

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;

@property (nonatomic, retain) IBOutletCollection(UIProgressView) NSArray *progressBar;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *labelValues;


@property (nonatomic, retain) IBOutlet UIButton *movingButtonOutlet;

@property (retain, nonatomic) IBOutlet UISwitch *xInvertSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *yInvertSwitch;


@end
