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


    //MARK: Show Pop Over
- (IBAction)showMePopOver:(id)sender
{
    
    self.popOverVC = [[PopOverViewController alloc]initWithNibName:@"PopOverViewController" bundle:nil];
    
    /* updating popover view with exact frame (taking into consideration navbar as well) */
    if (self.navigationController.navigationBar != nil)
    {
        CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat calcYOrigin = self.view.bounds.origin.y + navBarHeight+1;
        CGFloat calcHeight = self.view.bounds.size.height - navBarHeight-1;
        
        CGRect popOverFrame = CGRectMake(self.view.bounds.origin.x,
                                         calcYOrigin,
                                         self.view.bounds.size.width,
                                         calcHeight);
        
        self.popOverVC.view.frame = popOverFrame;
    }
    else
    {
         self.popOverVC.view.frame = self.view.bounds;
    }
    
    UIImage * starWarsImage = [UIImage imageNamed:@"starWars.jpg"];
    
    [self.popOverVC showInView:self.view withImage:starWarsImage withMessage:@"May the Force be with You" animated:true];
    
}//eo-a

@end
