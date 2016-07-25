//
//  ViewController.h
//  textfieldAndButtons
//
//  Created by Luis Andres Castillo Hernandez on 11/21/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIButton *topBorder;


@property (weak, nonatomic) IBOutlet UIButton *bottomBorder;

@property (weak, nonatomic) IBOutlet UIButton *leftBorder;

@property (weak, nonatomic) IBOutlet UIButton *rightBorder;

@property (weak, nonatomic) IBOutlet UIButton *buttonWithBorder;



-(void)addTopBorderWithColor:(UIColor *)color
                andWidth:(CGFloat) borderWidth
              buttonToUpdate:(UIButton *) buttonProvided;

- (void)addBottomBorderWithColor:(UIColor *)color
                        andWidth:(CGFloat) borderWidth
                  buttonToUpdate:(UIButton *) buttonProvided;

- (void)addLeftBorderWithColor:(UIColor *)color
                      andWidth:(CGFloat) borderWidth
                buttonToUpdate:(UIButton *) buttonProvided;


- (void)addRightBorderWithColor:(UIColor *)color
                       andWidth:(CGFloat) borderWidth
                 buttonToUpdate:(UIButton *) buttonProvided;




@end

