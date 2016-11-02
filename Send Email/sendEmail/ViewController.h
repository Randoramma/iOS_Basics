//
//  ViewController.h
//  sendEmail
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageSelected;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (IBAction)sendEmail:(UIButton *)sender;


- (IBAction)sendEmailWithImage:(UIButton *)sender;


@end

