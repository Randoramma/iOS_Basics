//
//  ViewController.h
//  sendSMS
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelected;

- (IBAction)sendSMS:(UIButton *)sender;

- (IBAction)sendSMSWithImage:(UIButton *)sender;



@end

