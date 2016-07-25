//
//  VCThatCallsPopOverViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/30/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "VCThatCallsPopOverViewController.h"

#import "PopOverViewController.h"

@interface VCThatCallsPopOverViewController ()

@end

@implementation VCThatCallsPopOverViewController

@synthesize popOverVC;


    //MARK: View Loading
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

    //MARK: Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    //MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


    //MARK: Show Pop Over
- (IBAction)showMePopOver:(id)sender
{
    
    self.popOverVC = [[PopOverViewController alloc]initWithNibName:@"PopOverViewController" bundle:nil];
    
    
    UIImage * starWarsImage = [UIImage imageNamed:@"starWars.jpg"];
    
    [self.popOverVC showInView:self.view withImage:starWarsImage withMessage:@"May the Force be with You" animated:true];
    
}//eo-a

@end
