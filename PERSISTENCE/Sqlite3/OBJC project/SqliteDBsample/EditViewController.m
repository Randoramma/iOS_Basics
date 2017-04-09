//
//  EditViewController.m
//  SqliteDBsample
//
//  Created by Luis Castillo on 8/12/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController


#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Set textfield delegates
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.age.delegate = self;
    
    //setting db
    self.dbManager = [[DBManager alloc]initWithDatabaseFilename:@"sampledb1.sql"];
    
    // Check if should load specific record for editing.
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
}//eom


#pragma mark - 
-(void)loadInfoToEdit
{
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from peopleInfo where peopleInfoID=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    id result = [results objectAtIndex:0];
    NSString * fname = [result objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"] ];
    
    NSString * lname = [result objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"] ];
    
    id age = [result objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"] ];
                 
    // Set the loaded data to the textfields.
    self.firstName.text = fname;
    self.lastName.text = lname;
    self.age.text = age;

}//eom

#pragma mark - Save
- (IBAction)saveInfo:(id)sender {
    
    NSString * fname = self.firstName.text;
    NSString * lname = self.lastName.text;
    NSString * ageString = self.age.text;
    
    if( ([fname length] > 0)
       && ([lname length] > 0)
       && ([ageString length] > 0) )
    {
        [self saveNewPersonToDB:fname withLastName:lname andAge:ageString];
    }
    else
    {
        NSLog(@"Please enter all values");
    }
}//eom


-(void)saveNewPersonToDB:(NSString *) fname withLastName:(NSString *) lname andAge:(NSString *) ageString
{
    int age = [ageString intValue];
    
    // Prepare the query string.
    // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
    NSString *query;
    if (self.recordIDToEdit == -1)
    {
        query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)", fname, lname, age];
    }
    else
    {
        query = [NSString stringWithFormat:@"update peopleInfo set firstname='%@', lastname='%@', age=%d where peopleInfoID=%d", fname, lname, age, self.recordIDToEdit];
    }
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}//eom


#pragma mark - Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == self.firstName)
    {
        [self.lastName becomeFirstResponder];
    }
    else if (textField == self.lastName)
    {
        [self.age becomeFirstResponder];
    }
    else if (textField == self.age)
    {
        [self saveInfo:nil];
    }
    
    return  TRUE;
}//eom



#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//eom


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}//eom

@end
