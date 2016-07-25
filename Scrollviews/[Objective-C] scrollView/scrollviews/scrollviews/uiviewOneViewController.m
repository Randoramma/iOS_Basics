//
//  uiviewOneViewController.m
//  scrollviews
//
//  Created by Luis Castillo on 1/24/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import "uiviewOneViewController.h"

@interface uiviewOneViewController ()

@end

@implementation uiviewOneViewController

@synthesize scrollview;
@synthesize myView;
@synthesize partyLabel, partySwitch, partyNameTextfield;

    //MARK: View Loading
- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}//eom

-(void)viewDidAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}//eom

    //MARK: Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


    //MARK: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
}

    //MARK: textfield delegates
-(bool)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}//eom

    //MARK: - Keyboard Observers

    // Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

    //    // Called when the UIKeyboardDidShowNotification is sent.
    //- (void)keyboardWasShown:(NSNotification*)aNotification
    //{
    //    NSDictionary* info = [aNotification userInfo];
    //    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    //    scrollview.contentInset = contentInsets;
    //    scrollview.scrollIndicatorInsets = contentInsets;
    //
    //        // If active text field is hidden by keyboard, scroll it so it's visible
    //        // Your app might not need or want this behavior.
    //    CGRect aRect = self.view.frame;
    //    aRect.size.height -= kbSize.height;
    //    if (!CGRectContainsPoint(aRect, activeField.frame.origin) )
    //        {
    //        [self.scrollview scrollRectToVisible:activeField.frame animated:YES];
    //        }
    //}//eom

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info      = [aNotification userInfo];
    CGSize kbSize           = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect        = myView.superview.frame;
    bkgndRect.size.height += kbSize.height;
    
    [myView.superview setFrame:bkgndRect];
    [scrollview setContentOffset:CGPointMake(0.0, myView.frame.origin.y-kbSize.height) animated:YES];
}//eom

    // Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets          = UIEdgeInsetsZero;
    scrollview.contentInset             = contentInsets;
    scrollview.scrollIndicatorInsets    = contentInsets;
}//eom


@end
