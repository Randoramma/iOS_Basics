//
//  AddNotificationViewController.h
//  localNotification
//
//  Created by Luis Andres Castillo Hernandez on 11/12/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNotificationViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>
{
    UIDatePicker * firedatePickerView;
    NSDate * dateSelected;
}

@property (weak, nonatomic) IBOutlet UILabel *totalNotifications;


@property (weak, nonatomic) IBOutlet UITextField *time;

@property (weak, nonatomic) IBOutlet UITextField *date;

@property (weak, nonatomic) IBOutlet UITextField *message;

- (IBAction)addNotification:(id)sender;



@end
