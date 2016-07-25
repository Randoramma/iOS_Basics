//
//  ViewNotificationsViewController.m
//  localNotification
//
//  Created by Luis Andres Castillo Hernandez on 11/12/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import "ViewNotificationsViewController.h"

@interface ViewNotificationsViewController ()

@end

@implementation ViewNotificationsViewController

@synthesize fireDate, fireTime, message, totalNotifications;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}//eo-view


/* */
-(void)viewDidAppear:(BOOL)animated
{
    UIApplication *app          = [UIApplication sharedApplication];
    NSArray *allNotifications   = [app scheduledLocalNotifications];
    
    //updating total number of notifications
    totalNotifications.text = [NSString stringWithFormat:@"%ld", (long)[allNotifications count]];
    
    
    // NSLog(@"%@", allNotifications);
    
    //updating labels with notifications
    for ( int iter = 0 ; iter < allNotifications.count ; iter++)
    {
        UILocalNotification * currNotification = allNotifications[iter];

        //valid label
        if(  (iter >= 0) && (iter < 4)  )
        {
           //  NSLog(@"[%d] %@", iter , currNotification.debugDescription );
            
            //current Labels
            UILabel * currFireDateTextfield =  fireDate[iter];
            UILabel * currFireTimeTextfield =  fireTime[iter];
            UILabel * currMessageTextfield  =  message[iter];

            //firedate
            NSDate * date               = currNotification.fireDate;
            
            //date textfield
            NSDateFormatter *formatterA = [[NSDateFormatter alloc] init];
            [formatterA setDateFormat:@"MM-dd-yyyy"];
            NSString * datefire = [formatterA stringFromDate:date];
            
            //time textfield
            NSDateFormatter *formatterB = [[NSDateFormatter alloc] init];
            [formatterB setTimeStyle:NSDateFormatterMediumStyle];
            NSString * timeFire = [formatterB stringFromDate:date];
            
            //updating labels
            currFireDateTextfield.text  = datefire;
            currFireTimeTextfield.text  = timeFire;
            currMessageTextfield.text   = currNotification.alertBody;
        }//eo-valid
        
    }//eo-fl
    
}//eoi-view

/* */
- (IBAction)cancelAllNotifications:(id)sender
{
    //canceling any existing location notifications pending
    UIApplication *app          = [UIApplication sharedApplication];
    NSArray *oldNotification    = [app scheduledLocalNotifications];
    if( [oldNotification count] > 0  )
    {
        [app cancelAllLocalNotifications];
    }
    
    //updating notification count
    totalNotifications.text = @"0";

}//eo-action


/* */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
