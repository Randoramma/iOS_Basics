//
//  carDetailViewController.h
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addCarViewController : UIViewController

@property (strong) NSManagedObjectModel * device;

@property (weak, nonatomic) IBOutlet UITextField *carMake;
@property (weak, nonatomic) IBOutlet UITextField *carModel;
@property (weak, nonatomic) IBOutlet UITextField *carYear;

- (IBAction)saveCar:(UIButton *)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
