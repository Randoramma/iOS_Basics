//
//  AddNotificationViewController.m
//  localNotification
//
//  Created by Luis Andres Castillo Hernandez on 11/12/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import "AddNotificationViewController.h"

@interface AddNotificationViewController ()

@end

@implementation AddNotificationViewController

@synthesize message, time, date, totalNotifications;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}//eo-view

-(void)viewDidAppear:(BOOL)animated
{
    totalNotifications.text = @"0";
    
    NSInteger totalNumberNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    
    totalNotifications.text = [NSString stringWithFormat:@"%ld", (long)totalNumberNotifications];

    
    
    [self createDatePickerForFireDate];
}//eo-view

- (void)didReceiveMemoryWarning {
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

/* */
- (IBAction)addNotification:(id)sender
{
    //requiered fields are filled
    if(  ( (time.text.length > 0) ||  (date.text.length > 0) ) &&  (message.text.length > 0) )
    {
        //adding notification
        NSDate * currentDate                = [NSDate date];
        NSDate *alarmTime;
        
        
        if(  (time.text.length > 0) )
        {
            int timeValue   = [time.text intValue];
            alarmTime       = [ currentDate dateByAddingTimeInterval:timeValue];
        }
        else if( (date.text.length > 0) )
        {
            alarmTime       = dateSelected;
        }

        
        //obtaining the total notifications
        NSInteger totalNotificationCountBeAddition = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
        
        
        UIApplication *app                  = [UIApplication sharedApplication];
        UILocalNotification *notifyAlarm    = [ [UILocalNotification alloc] init];
        
        if(notifyAlarm)
        {
            notifyAlarm.fireDate            = alarmTime;
            notifyAlarm.timeZone            = [NSTimeZone defaultTimeZone];
            notifyAlarm.repeatInterval      =   0;
            notifyAlarm.alertTitle          = @"Local Notification Title";
            notifyAlarm.alertBody           = message.text;
            
            [app scheduleLocalNotification:notifyAlarm];
        }
        
        //obtaining the total notifications
        NSInteger newTotalNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
        
        if( newTotalNotifications >  totalNotificationCountBeAddition)
        {
            //show user notification was added
            [self showAlert:@"Notification Added"
                withMessage:@"Notification Added!"
                        and:@"Cancel"];

        }
        else
        {
            //show user notification was added
            [self showAlert:@"Notification Notice"
                withMessage:@"unable to add Notification"
                        and:@"Cancel"];

        }
        
        //updating total notifications
        totalNotifications.text = [NSString stringWithFormat:@"%ld", (long)newTotalNotifications];

        
        //clearing input fields
        message.text    = @" ";
        date.text       = @" ";
        time.text       = @" ";
        
    }
    else
    {
        [self showAlert:@"Missing Input Fields" withMessage:@"Please make sure to input a message and time or date" and:@"Cancel"];
    }
}//eo-action


//MARK: Helper Methods
    /* create UIAlert*/
    -(void) showAlert:(NSString*)title withMessage:(NSString*)incomingMessage and:(NSString*) cancelTitle
    {
        //for iOS9
        if( [UIAlertController class])
        {
            // use UIAlertController
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:title
                                       message:incomingMessage
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   NSLog(@"Okay btn pressed");
                                               }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                   style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       NSLog(@"Cancel btn pressed");
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
            
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        else //for older versions before ios9
        {
            UIAlertView * alert =[[UIAlertView alloc]
                                                        initWithTitle:title
                                                             message:incomingMessage
                                                            delegate:self
                                                   cancelButtonTitle:cancelTitle
                                                   otherButtonTitles: nil];
            [alert show];//display alert
        }
    }//eom


//MARK: Picker Methods
    /* creating a UiDatePicker for date of date textfield */
    -(void)createDatePickerForFireDate
    {
        //calculating starting date for datepicker
        NSDate *now                 = [NSDate date];
        NSDateComponents *minusTime = [NSDateComponents new];
        minusTime.hour              = +24;
        NSDate *calculatedDate      = [[NSCalendar currentCalendar] dateByAddingComponents:minusTime
                                                                    toDate:now
                                                                    options:0];
        
        // create a UIPicker view as a custom keyboard view
        firedatePickerView = [[UIDatePicker alloc] init];
        [firedatePickerView sizeToFit];
        firedatePickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [firedatePickerView setDate:calculatedDate];//setting starting date
        self.date.inputView = firedatePickerView;
        
        // creating toolbar for 'Cancel' and 'Done' actions
        UIToolbar* keyboardDoneButtonView   = [[UIToolbar alloc] init];
        keyboardDoneButtonView.barStyle     = UIBarStyleBlack;
        keyboardDoneButtonView.translucent  = YES;
        keyboardDoneButtonView.tintColor    = nil;
        [keyboardDoneButtonView sizeToFit];
        
        //creating empty UIBarItem to force first item to the right
        UIBarButtonItem* empty1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        //creating 'Cancel' UIBarItem to be the exit point for the picker
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(cancelClicked:)];
        
        
        //creating 'Done' UIBarItem to be the exit point for the picker
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doneClicked:)];
        
        //adding UIBarItems to the Keyboard/DatePicker
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:empty1, cancelButton, doneButton, nil]];
        
        // Plug the keyboardDoneButtonView into the text field
        self.date.inputAccessoryView = keyboardDoneButtonView;
    }//eom

    //makes the date first responder upon touching the uitextfield
    - (void)setDateClicked:(id)sender
    {
        [self.date becomeFirstResponder];
    }

    //process the date selected after the user click cancel
    //   and resign being the first reponsder
    - (void)cancelClicked:(id)sender
    {
        [self.date resignFirstResponder];
    }//eom

    //process the date selected after the user click done
    //   and resign being the first reponsder
    - (void)doneClicked:(id)sender
    {
        [self.date resignFirstResponder];
     
        //updating the texfield so the user can see the date selected
        
        NSDate *selectedDate = [self->firedatePickerView date]; //getting date from datepicker
        self.date.text = [NSString stringWithFormat:@"%@",selectedDate];

//        
//        //converted needed for nsstring
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MM-dd-yyyy"];
//        
//        //Optionally for time zone conversions
//        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//        
//        NSDate *selectedDate = [self->firedatePickerView date]; //getting date from datepicker
//        
//        dateSelected = selectedDate;
//        
//    //    //updating dob NSstring to be sent to the next controller
//    //    self.dateOfBirthSelected = [formatter stringFromDate:selectedDate];
//        
//        //updating the texfield so the user can see the date selected
//        self.date.text = [formatter stringFromDate:selectedDate];
//
    }//eom

//MARK: textfield delegates

    /* */
    -(BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        [textField resignFirstResponder];
        
        return YES;
    }//eom

    /* */
    -(void)textFieldDidEndEditing:(UITextField *)textField
    {
        [textField resignFirstResponder];
    }//eom

//MARK: touches

    /* dimmisses UITextField as soon the background is touched */
    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
    {
        [message resignFirstResponder];
        [time resignFirstResponder];
    }//eom




@end
