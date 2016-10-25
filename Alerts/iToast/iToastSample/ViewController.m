//
//  ViewController.m
//  iToastSample
//
//  Created by Luis Castillo on 9/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize locationSegmentedControl, durationSegmentedControl, typeSegmentedControl;
@synthesize showToastButton, messageToDisplayLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showToast:(id)sender
{
    
    //what message to display?
    NSString * msgToDisplay = self.messageToDisplayLabel.text;
    if ([msgToDisplay length ] < 1) {
        msgToDisplay = @"Hello from iToast";
    }
    
    //where do we display the toast message?
    iToastGravity locationType;
    switch (locationSegmentedControl.selectedSegmentIndex) {
        //top
        case 0:
            locationType = iToastGravityTop;
            break;
        //center
        case 1:
            locationType = iToastGravityCenter;
            break;
        //bottom
        case 2:
            locationType = iToastGravityBottom;
            break;
        default:
            
            break;
    }
    
    //how long to display message?
    //  NOTE: this value can also be a integer (milliseconds displaying it)
    iToastDuration duration ;
    switch (durationSegmentedControl.selectedSegmentIndex)
    {
        //short
        case 0:
            duration = iToastDurationShort;
            break;
        //normal
        case 1:
            duration = iToastDurationNormal;
            break;
        //long
        case 2:
            duration = iToastDurationLong;
            break;
        default:
            break;
    }
    
    //type of toast?
    iToastType typeOfToast;
    switch (typeSegmentedControl.selectedSegmentIndex) {
        //none
        case 0:
            typeOfToast = iToastTypeNone;
            break;
        //info
        case 1:
            typeOfToast = iToastTypeInfo;
            break;
        //warning
        case 2:
            typeOfToast = iToastTypeWarning;
            break;
        //notice
        case 3:
            typeOfToast = iToastTypeNotice;
            break;
            
        default:
            break;
    }
    
    [[[[iToast makeText:msgToDisplay] setGravity:locationType] setDuration:duration] show:typeOfToast];
}//eo-a


@end
