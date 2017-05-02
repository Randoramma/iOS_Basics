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


//MARK: - Observers
-(void)menuTapped {
    if(self.shareSettings.menuTapped){
        [self hideMenuView];
    }
    else{
        [self showMenuView];
    }
    self.shareSettings.menuTapped = !self.shareSettings.menuTapped;
}

//MARK: - Menu
-(void)showMenuView{
    [UIView animateWithDuration:0.3 animations:^{
        self.MainVC.frame = CGRectMake(260, self.MainVC.frame.origin.y, self.MainVC.frame.size.width, self.MainVC.frame.size.height);
        
        self.MenuVC.frame = CGRectMake(0, self.MenuVC.frame.origin.y, self.MenuVC.frame.size.width, self.MenuVC.frame.size.height);
    }];
}

-(void)hideMenuView{
    [UIView animateWithDuration:0.3 animations:^{
        self.MainVC.frame = CGRectMake(0,
                                       self.MainVC.frame.origin.y,
                                       self.MainVC.frame.size.width,
                                       self.MainVC.frame.size.height);
        
        self.MenuVC.frame = CGRectMake(-260,
                                       self.MenuVC.frame.origin.y,
                                       self.MenuVC.frame.size.width,
                                       self.MenuVC.frame.size.height);
    }];
}


//MARK: - Profile
-(void)profileTapped{
    if(self.shareSettings.profileTapped){
        [self hideProfileView];
    } else{
        [self showProfileView];
    }
    self.shareSettings.profileTapped = !self.shareSettings.profileTapped;
}

-(void)showProfileView{
    [UIView animateWithDuration:0.3 animations:^{
        self.MainVC.frame = CGRectMake(-260,
                                       self.MainVC.frame.origin.y,
                                       self.MainVC.frame.size.width,
                                       self.MainVC.frame.size.height);
        
        self.ProfileVC.frame = CGRectMake(0,
                                          self.ProfileVC.frame.origin.y,
                                          self.ProfileVC.frame.size.width,
                                          self.ProfileVC.frame.size.height);
    }];
}

-(void)hideProfileView{
    [UIView animateWithDuration:0.3 animations:^{
        self.MainVC.frame = CGRectMake(0,
                                       self.MainVC.frame.origin.y,
                                       self.MainVC.frame.size.width,
                                       self.MainVC.frame.size.height);
        
        self.ProfileVC.frame = CGRectMake(260,
                                          self.ProfileVC.frame.origin.y,
                                          self.ProfileVC.frame.size.width,
                                          self.ProfileVC.frame.size.height);
    }];
}

@end
