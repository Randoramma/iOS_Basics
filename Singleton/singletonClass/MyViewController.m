//
//  ViewController.m
//  singletonClass
//
//  Created by Luis Castillo on 10/5/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    AppModel * firstModel = [AppModel sharedInstance];
    AppModel * secondModel = [AppModel sharedInstance];
    
    [firstModel updateModelName:@"Cool Model"];
    [firstModel updateModelNumber:@"9876345652"];
    
    
    [secondModel updateModelName:@"Awesome Model"];
    
    [firstModel debug];
    [secondModel debug];
    
}//eom

@end
