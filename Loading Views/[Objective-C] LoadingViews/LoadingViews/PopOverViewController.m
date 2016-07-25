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
    
    self.view.backgroundColor           = [[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius   = 5;
    self.popUpView.layer.shadowOpacity  = 0.8;
    self.popUpView.layer.shadowOffset   = CGSizeMake(0.0f, 0.0f);

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}//eom

    //MARK: Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    //MARK - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

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
    
    NSLog(@"closePopup");
    
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

@end
