//
//  PopOverViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/30/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "PopOverViewController.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController

@synthesize popUpView, logoImage, messageLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
            // Custom initialization
    }
    return self;
}

    //MARK: View Loading
- (void)viewDidLoad {
    
    [self debug];

//    CGRect mainscreen_bounds = [UIScreen mainScreen] .bounds;
//    CGFloat navBarHeight = super.navigationController.navigationBar.frame.size.height;
//    if (navBarHeight > 0)
//    {
//        CGFloat mainscreen_UpdatedHeight = mainscreen_bounds.size.height-navBarHeight-1;
//        
//        
//        self.view.frame = mainscreen_bounds;
//    }
//    else
//    {
//        self.view.frame = mainscreen_bounds;
//    }
    
    
    
    [super viewDidLoad];

    
    self.view.backgroundColor           = [[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius   = 5;
    self.popUpView.layer.shadowOpacity  = 0.8;
    self.popUpView.layer.shadowOffset   = CGSizeMake(0.0f, 0.0f);

    [self debug];
}//eom

//MARK: Animations
-(void) showAnimation
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}//eom


-(void) removeAnimation
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}//eom

- (IBAction)closePopup:(id)sender {
    [self removeAnimation];
}//eo-a



- (void)showInView:(UIView *)aView
        withImage:(UIImage*) imageProvided
       withMessage:(NSString *)msgProvided
          animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aView addSubview:self.view];
        self.logoImage.image = imageProvided;
        self.messageLabel.text = msgProvided;
        if (animated) {
            [self showAnimation];
        }
    });
}


-(void)debug
{
    CGRect bounds_mainscreen = [UIScreen mainScreen] .bounds;
    CGRect vc_bounds = self.view.bounds;
    CGRect vc_frame = self.view.frame;
    
    NSLog(@"[main screen - bounds] x,y (%f, %f)",bounds_mainscreen.origin.x, bounds_mainscreen.origin.y);
    NSLog(@"[main screen - bounds] width,height (%f,%f)",bounds_mainscreen.size.width, bounds_mainscreen.size.height );
    
    NSLog(@"[VC - bounds] x,y (%f, %f)",vc_bounds.origin.x, vc_bounds.origin.y);
    NSLog(@"[VC - bounds] width,height (%f,%f)",vc_bounds.size.width, vc_bounds.size.height );
    
    NSLog(@"[VC - frame] x,y (%f, %f)",vc_frame.origin.x, vc_frame.origin.y);
    NSLog(@"[VC - frame] width,height (%f,%f)",vc_frame.size.width, vc_frame.size.height );
    
}//eom
@end
