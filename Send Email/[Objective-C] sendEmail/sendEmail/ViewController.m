//
//  ViewController.m
//  sendEmail
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize messageLabel;
@synthesize imageSelected;

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





/* sending email with NO attachment */
- (IBAction)sendEmail:(UIButton *)sender
{

    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc]init];
    
    [composer setMailComposeDelegate:self];
    
    //checking if device is avaliable for sending email
    
    if(  [MFMailComposeViewController canSendMail] )
    {
        
        NSArray * receipents = [[NSArray alloc]initWithObjects:@" ", nil];
        
        [composer setToRecipients:receipents];
        [composer setSubject:@"This is a test email"];
        [composer setMessageBody:messageLabel.text isHTML:NO];
        
        //
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This Device can NOT send emails!");
    }
    
}//eo-action


/* sending email with image attachment */
- (IBAction)sendEmailWithImage:(UIButton *)sender
{

    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc]init];
    
    [composer setMailComposeDelegate:self];
    
    //checking if device is avaliable for sending email
    
    if(  [MFMailComposeViewController canSendMail] )
    {
        
        NSArray * receipents = [[NSArray alloc]initWithObjects:@" ", nil];
        
        [composer setToRecipients:receipents];
        [composer setSubject:@"This is a test email"];
        [composer setMessageBody:messageLabel.text isHTML:NO];
        
        
        //preparing image
        NSData * imageData = UIImageJPEGRepresentation(self.imageSelected.image, 1);
        
        //adding image
        [composer addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"imageOfStarWars.jpg"];
        
        //
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This Device can NOT send emails!");
    }

}//eo-action





//MARK: mail compose delegates
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{

    [self dismissViewControllerAnimated:YES completion:NULL];

    //error
    if(error)
    {
        NSLog(@"%@", [error description]);
    }
    
    
    
}//eom

@end
