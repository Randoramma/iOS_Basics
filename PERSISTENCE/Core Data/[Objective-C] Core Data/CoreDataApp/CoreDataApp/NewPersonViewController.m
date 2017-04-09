//
//  NewPersonViewController.m
//  CoreDataApp
//
//  Created by Luis Andres Castillo Hernandez on 9/14/15.
//  Copyright (c) 2015 DevBros. All rights reserved.
//

#import "NewPersonViewController.h"

@interface NewPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;

@end

@implementation NewPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"New Person";
}//eom


/**/
- (IBAction)save:(UIButton *)sender {
    [self newPerson];
}

/**/
-(void)newPerson
{
    //ignoring empty entries
    if(self.firstName.text.length != 0)
    {
        
        NSManagedObject * managedPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext: _managedObjectContext];
        
        NSManagedObject * managedAddress = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext: _managedObjectContext];
        
        [managedPerson setValue:self.firstName.text forKey:@"firstname"];
        
        [managedPerson setValue:self.lastName.text forKey:@"lastname"];
        
        
        [managedPerson setValue:[NSNumber numberWithInteger:[self.age.text integerValue]] forKey:@"age"];
        
        [managedAddress setValue:self.address.text forKey:@"address"];
        
        [managedAddress setValue:self.city.text forKey:@"city"];
        
        
        [managedAddress setValue:self.state.text forKey:@"state"];
        
        NSError * error;
        if(! [_managedObjectContext save:&error])
        {
            NSLog(@"Problems saving the information %@", [error localizedDescription]);
            [self showAlert:[error localizedDescription]];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:true];
        }
    }//eom
}//eom


- (IBAction)return:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:true];
}//eom


//MARK: Alert
-(void)showAlert:(NSString *) message
{
    UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction * okayAction = [UIAlertAction actionWithTitle:@"Okay" style:(UIAlertActionStyle) UIAlertActionStyleDefault handler:nil];
    
    [alertCont addAction:okayAction];
    
    [self presentViewController:alertCont animated:true completion:nil];
}//eom


//MARK:  textfields
        /* dimisses UITextField as soon the return key is pressed */
        -(BOOL)textFieldShouldReturn:(UITextField *)textField {
            
            if(textField == self.firstName){
                [self.firstName resignFirstResponder];
                [self.lastName becomeFirstResponder];
            }
            else if(textField == self.lastName){
                [self.lastName resignFirstResponder];
                [self.age becomeFirstResponder];
            }
            else if(textField == self.age){
                [self.age resignFirstResponder];
                [self.address becomeFirstResponder];
            }
            else if(textField == self.address){
                [self.address resignFirstResponder];
                [self.city becomeFirstResponder];
            }
            else if(textField == self.city){
                [self.city resignFirstResponder];
                [self.state becomeFirstResponder];
            }
            else if(textField == self.state){
                [self.state resignFirstResponder];
            }
            else{
                NSLog(@"none are the same");
            }
            
            return YES;
        }//eom

@end
