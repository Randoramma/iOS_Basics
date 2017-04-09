//
//  carDetailViewController.m
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import "addCarViewController.h"

#import <CoreData/CoreData.h>


@interface addCarViewController ()

@end

@implementation addCarViewController

@synthesize device;



//MARK:

-(NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate  performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
    
}//eom



//MARK: View Loading
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //the previous view wants to edit the information
    if (self.device)
    {
        //getting the car existing info
        NSString * currCarMake  = [self.device valueForKey:@"carMake"];
        NSString * currCarModel = [self.device valueForKey:@"carModel"];
        NSString * currCarYear  = [self.device valueForKey:@"carYear"];
        
        //updating the textfields with this info
        [self.carMake setText:currCarMake];
        [self.carModel setText:currCarModel];
        [self.carYear setText:currCarYear];
    }
}

//MARK: Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveCar:(UIButton *)sender
{
    NSManagedObjectContext * context = [self managedObjectContext];
    
    //saving existing entry
    if (self.device)
    {
        [self.device setValue:self.carMake.text forKey:@"carMake"];
        [self.device setValue:self.carModel.text forKey:@"carModel"];
        [self.device setValue:self.carYear.text forKey:@"carYear"];
    }
    //saving a new entry
    else
    {
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        
        [newDevice setValue:self.carMake.text forKey:@"carMake"];
        [newDevice setValue:self.carModel.text forKey:@"carModel"];
        [newDevice setValue:self.carYear.text forKey:@"carYear"];
    }

    //checking if error saving values occurred
    NSError * error = nil;
    if( ![context save:&error])
    {
        NSLog(@"%@ %@", error, [error localizedDescription]);
        
        [self showAlert:[error localizedDescription]];
    }
    else
    {
        // going back to previous view
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}//eo-action

- (IBAction)dismissKeyboard:(id)sender
{
    
    
}//eo-action

//MARK: Alert
-(void)showAlert:(NSString *) message
{
    UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction * okayAction = [UIAlertAction actionWithTitle:@"Okay" style:(UIAlertActionStyle) UIAlertActionStyleDefault handler:nil];
    
    [alertCont addAction:okayAction];
    
    [self presentViewController:alertCont animated:true completion:nil];
}//eom


@end
