

//  QuizViewController.m
//  Quiz
//
//  Created by Luis Andres Castillo Hernandez on 9/1/15.
//  Copyright (c) 2015 FIU.LuisCastillo. All rights reserved.
//

#import "MyScrollViewController.h"
#import "aViewControllerInSBViewController.h"

@interface MyScrollViewController ()


           
@end

@implementation MyScrollViewController
@synthesize myScrollview;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.myScrollview.contentSize = self.myScrollview.frame.size;
        
    }//eo-if
    
    // Return the address of the new object
    return self;
}//eom

#pragma mark - views

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}//eo-view

-(void)viewDidAppear:(BOOL)animated
{

}//eo-view

#pragma mark - Leave NIB to a Storyboard view controller
- (IBAction)pushToAViewControllerInStoryBoard:(id)sender
{
    NSString *storyboardName = @"main";
    
    //creating storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    //creating controller thats in storyboard
    
//    NSString *controllerID   = @"aViewControllerInSB";
//    aViewControllerInSBViewController *myNewController = (aViewControllerInSBViewController *)[storyboard instantiateViewControllerWithIdentifier:controllerID];
    
     UIViewController * firstController = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:firstController animated:YES];
    
}//eo-action

#pragma mark -

- (void)didReceiveMemoryWarning
{
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
