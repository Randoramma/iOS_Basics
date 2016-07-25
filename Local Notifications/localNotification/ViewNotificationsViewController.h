//
//  ViewNotificationsViewController.h
//  localNotification
//
//  Created by Luis Andres Castillo Hernandez on 11/12/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewNotificationsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *totalNotifications;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fireDate;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fireTime;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *message;


- (IBAction)cancelAllNotifications:(id)sender;





@end
