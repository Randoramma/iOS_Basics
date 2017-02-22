//
//  ContainerVCViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ContainerVCViewController.h"
#import "ShareSetting.h"

@interface ContainerVCViewController ()
@property (weak, nonatomic) IBOutlet UIView *MenuVC;
@property (weak, nonatomic) IBOutlet UIView *ProfileVC;
@property (weak, nonatomic) IBOutlet UIView *MainVC;


@property (strong, nonatomic) ShareSetting * shareSettings;


@end

@implementation ContainerVCViewController


/*
 MenuVC:
    The container position X: -260  Y: 20 Width: 320 Height: 548
 
 ProfileVC:
    The container position X: 260   Y: 20 Width: 320 Height: 548
 
 MainVC:
    The container position X: 0     Y: 20 Width: 320 Height: 548
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shareSettings = [ShareSetting sharedSettings];
    self.shareSettings.menuTapped=NO;
    self.shareSettings.profileTapped=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuTapped) name:@"menuTapped" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileTapped) name:@"profileTapped" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"menuTapped" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"profileTapped" object:nil];
}


    //MARK: Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //MARK: Observers

-(void)menuTapped
{
    if(self.shareSettings.menuTapped)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.MainVC.frame = CGRectMake(0, self.MainVC.frame.origin.y, self.MainVC.frame.size.width, self.MainVC.frame.size.height);
            
            self.MenuVC.frame = CGRectMake(-260,  self.MenuVC.frame.origin.y, self.MenuVC.frame.size.width, self.MenuVC.frame.size.height);
        }];
    } else{
        [UIView animateWithDuration:0.3 animations:^{
            self.MainVC.frame = CGRectMake(260, self.MainVC.frame.origin.y, self.MainVC.frame.size.width, self.MainVC.frame.size.height);
            
            self.MenuVC.frame = CGRectMake(0, self.MenuVC.frame.origin.y, self.MenuVC.frame.size.width, self.MenuVC.frame.size.height);
        }];
    }
    self.shareSettings.menuTapped = !self.shareSettings.menuTapped;
}

-(void)profileTapped
{
    if(self.shareSettings.profileTapped){
        [UIView animateWithDuration:0.3 animations:^{
            self.MainVC.frame = CGRectMake(0, self.MainVC.frame.origin.y, self.MainVC.frame.size.width, self.MainVC.frame.size.height);
            
            self.ProfileVC.frame = CGRectMake(260,  self.ProfileVC.frame.origin.y, self.ProfileVC.frame.size.width, self.ProfileVC.frame.size.height);
        }];
    } else{
        [UIView animateWithDuration:0.3 animations:^{
            self.MainVC.frame = CGRectMake(-260, self.MainVC.frame.origin.y, self.MainVC.frame.size.width, self.MainVC.frame.size.height);
            
            self.ProfileVC.frame = CGRectMake(0, self.ProfileVC.frame.origin.y, self.ProfileVC.frame.size.width, self.ProfileVC.frame.size.height);
        }];
    }
    self.shareSettings.profileTapped = !self.shareSettings.profileTapped;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
