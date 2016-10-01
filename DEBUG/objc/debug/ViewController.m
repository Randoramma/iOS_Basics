//
//  ViewController.m
//  debug
//
//  Created by Luis Castillo on 10/1/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#if DEBUG
    NSLog(@"Debug mode");
    self.view.backgroundColor = [UIColor redColor];
#else
    NSLog(@"Regular mode");
    self.view.backgroundColor = [UIColor greenColor];
#endif
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
