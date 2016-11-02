//
//  ViewControllerObjc.h
//  sendSMS
//
//  Created by Luis Castillo on 11/1/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>


@interface ViewControllerObjc : UIViewController<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelected;

- (IBAction)sendSMS:(UIButton *)sender;

- (IBAction)sendSMSWithImage:(UIButton *)sender;



@end
