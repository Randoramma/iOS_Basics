//
//  XIBViewController.m
//  scrollViewTest
//
//  Created by Luis Andres Castillo Hernandez on 10/17/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "XIBViewController.h"

@interface XIBViewController ()

@end

@implementation XIBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}//eo-action

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
