//
//  MainVCViewController.h
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *menuButton;


@property (weak, nonatomic) IBOutlet UIButton* profileButton;


- (IBAction)showMenu:(id)sender;

- (IBAction)showProfile:(id)sender;


@end
