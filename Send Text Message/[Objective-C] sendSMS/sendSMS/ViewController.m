//
//  ViewController.m
//  sendSMS
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageSelected;
@synthesize messageLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    imageSelected.image = [UIImage imageNamed:@"StarWars.jpg"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*   */
- (IBAction)sendSMS:(UIButton *)sender
{
    MFMessageComposeViewController * textComposer = [[MFMessageComposeViewController alloc]init];

    [textComposer setMessageComposeDelegate:self];
    
    //checking device can send SMS messages
    if( [MFMessageComposeViewController canSendText] )
    {
        NSArray * receipents = [NSArray arrayWithObjects:@" ", nil ];
        
        [textComposer setRecipients:receipents];
        
        // [textComposer setRecipients:NULL];
        
        [textComposer setBody:self.messageLabel.text ];
        
        [self presentViewController:textComposer animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"device cant send SMS messages");
    }
    
}//eo-action



/*   */
- (IBAction)sendSMSWithImage:(UIButton *)sender
{

    MFMessageComposeViewController * textComposer = [[MFMessageComposeViewController alloc]init];
    
    [textComposer setMessageComposeDelegate:self];
    
    //checking device can send SMS messages
    if( [MFMessageComposeViewController canSendText] )
    {
        NSArray * receipents = [NSArray arrayWithObjects:@" ", nil ];
        
        [textComposer setRecipients:receipents];
        
        // [textComposer setRecipients:NULL];
        
        [textComposer setBody:self.messageLabel.text];
        
        //preparing image
        NSData * imgData = UIImageJPEGRepresentation(self.imageSelected.image, 1);
        
        //adding Image to SMS message
        [textComposer addAttachmentData:imgData typeIdentifier:@"image/jpeg" filename:@"imageOfStarWars.jpeg"];
        
        
        [self presentViewController:textComposer animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"device cant send SMS messages");
    }
}//eo-action


//MARK: sms delegates
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{

    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"message cancelled");
            break;
        case MessageComposeResultFailed:
            NSLog(@"message failed");
            break;
        case MessageComposeResultSent:
            NSLog(@"message sent");
            break;
            
        default:
            break;
    }
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];

}//eom



@end
