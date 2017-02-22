//
//  MainVCViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "MainVCViewController.h"

@interface MainVCViewController ()

@end

@implementation MainVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)showMenu:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"menuTapped" object:nil];
}

- (IBAction)showProfile:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"profileTapped" object:nil];
}
@end
