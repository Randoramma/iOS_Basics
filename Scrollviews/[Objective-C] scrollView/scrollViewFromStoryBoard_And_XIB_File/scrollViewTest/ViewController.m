//
//  ViewController.m
//  scrollViewTest
//
//  Created by Luis Andres Castillo Hernandez on 10/16/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ViewController.h"
#import "XIBViewController.h"

@interface ViewController ()


@property (strong, nonatomic) IBOutlet XIBViewController *XIBViewController;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void) viewDidAppear:(BOOL)animated
{
    //navigate
    //[self.view addSubView:secondView];
    
    
    //return
    //[secondView removeFromSuperView];
    
    
   
    /*
      //in a navigation controller
     
     
     //to load/push to new controller use this code
     
         //this will be next screen
         DetailsViewController *detailsViewController = [[DetailsViewController alloc ]init];
         [self.navigationController pushViewController:detailsViewController animated:YES];
         
     
    // to go back or pop controller use this
     
         //now it will send back to parent screen
         [self.navigationController popViewControllerAnimated:YES];
     
     
     */
    
}



- (IBAction)goToXIB:(id)sender
{
    XIBViewController * xibViewController = [[XIBViewController alloc] init];
    
    //hiding the nav bar of the next view
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //     //WITHOUT NAV CONTROLLER
    //    [self presentViewController:xibViewController animated:YES completion:nil];
    
    //NAV CONTROLLER
    [self.navigationController pushViewController:xibViewController animated:YES];
    
}//eo-action


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
