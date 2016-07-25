//
//  ViewController.m
//  textfieldAndButtons
//
//  Created by Luis Andres Castillo Hernandez on 11/21/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

@synthesize topBorder, bottomBorder, leftBorder, rightBorder, buttonWithBorder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self addTopBorderWithColor:[UIColor blueColor] andWidth:2.0 buttonToUpdate:topBorder];
    
    
    [self addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:2.0 buttonToUpdate:bottomBorder];
    
    
    [self addLeftBorderWithColor:[UIColor redColor] andWidth:2.0 buttonToUpdate:leftBorder];
    
    
    [self addRightBorderWithColor:[UIColor greenColor] andWidth:2.0 buttonToUpdate:rightBorder];
    
        //buttonWithBorder
    [self MakeRoundBorder:buttonWithBorder withColor:[UIColor darkGrayColor] andWidth:0.8 andRadius:10];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addTopBorderWithColor:(UIColor *)color
                     andWidth:(CGFloat) borderWidth
               buttonToUpdate:(UIButton *) buttonProvided
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, buttonProvided.frame.size.width, borderWidth);
    [buttonProvided.layer addSublayer:border];
}//eom

- (void)addBottomBorderWithColor:(UIColor *)color
                        andWidth:(CGFloat) borderWidth
                  buttonToUpdate:(UIButton *) buttonProvided
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, buttonProvided.frame.size.height - borderWidth, buttonProvided.frame.size.width, borderWidth);
    [buttonProvided.layer addSublayer:border];
}//eom

- (void)addLeftBorderWithColor:(UIColor *)color
                      andWidth:(CGFloat) borderWidth
                buttonToUpdate:(UIButton *) buttonProvided
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, buttonProvided.frame.size.height);
    [buttonProvided.layer addSublayer:border];
}//eom

- (void)addRightBorderWithColor:(UIColor *)color
                       andWidth:(CGFloat) borderWidth
                 buttonToUpdate:(UIButton *) buttonProvided
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(buttonProvided.frame.size.width - borderWidth, 0, borderWidth, buttonProvided.frame.size.height);
    [buttonProvided.layer addSublayer:border];
}//eom


-(void)MakeRoundBorder:(UIButton *) button
                withColor:(UIColor *)color
            andWidth:(CGFloat) borderWidth
              andRadius:(CGFloat) cornerRadius
{

    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = color.CGColor;
    button.layer.cornerRadius = cornerRadius;
}//eom

@end
