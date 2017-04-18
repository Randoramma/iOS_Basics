//
//  ViewController.m
//  localNotification
//
//  Created by Luis Andres Castillo Hernandez on 11/12/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize totalNotifications;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 
}//eom


//MARK: Appear

-(void)viewDidAppear:(BOOL)animated
{
    
    totalNotifications.text = @"0";
    
    NSInteger totalNumberNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    
    totalNotifications.text = [NSString stringWithFormat:@"%ld", (long)totalNumberNotifications];

}//eo-view


-(void)viewWillAppear:(BOOL)animated
{
    
}//eo-view


//MARK: Disappear

-(void)viewDidDisappear:(BOOL)animated
{
   
}//eo-view



-(void)viewWillDisappear:(BOOL)animated
{


}//eo-view

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
