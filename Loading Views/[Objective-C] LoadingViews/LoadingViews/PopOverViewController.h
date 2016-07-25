//
//  PopOverViewController.h
//  LoadingViews
//
//  Created by Luis Castillo on 12/30/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface PopOverViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView
         withImage:(UIImage*) imageProvided
       withMessage:(NSString *)msgProvided
          animated:(BOOL)animated;

@end
