//
//  MainViewController.m
//  SqliteDBsample
//
//  Created by Luis Castillo on 8/12/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "MainViewController.h"
#import "DBManager.h"

@interface MainViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrPeopleInfo;

@property (nonatomic) int recordIDToEdit;
-(void)loadData;

@end

@implementation MainViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.peopleTable.delegate = self;
    self.peopleTable.dataSource = self;
    
    //setting db
    self.dbManager = [[DBManager alloc]initWithDatabaseFilename:@"sampledb1.sql"];
    
    [self loadData];
}//eom

#pragma mark -
- (IBAction)addNewPerson:(id)sender
{
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEdit = -1;
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}//eom

#pragma mark
-(void)loadData
{
    // Form the query.
    NSString *query = @"select * from peopleInfo";
    
    // Get the results.
    if (self.arrPeopleInfo != nil)
    {
        self.arrPeopleInfo = nil;
    }
    
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.peopleTable reloadData];
}//eom


#pragma mark - EditViewController Delegate
-(void)editingInfoWasFinished
{
    [self loadData];
}//eom

#pragma mark - Tableview Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}//eom


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.arrPeopleInfo.count;
}//eom


-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}//eom

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    id currPerson = [self.arrPeopleInfo objectAtIndex:indexPath.row];
    
    NSString * fname = [currPerson objectAtIndex:indexOfFirstname];
    NSString * lname = [currPerson objectAtIndex:indexOfLastname];
    id age = [currPerson objectAtIndex:indexOfAge];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", fname, lname ];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", age];
    
    return cell;
}//eom


#pragma mark Edit
-(void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
    id currRecord = [self.arrPeopleInfo objectAtIndex:indexPath.row];
    id currColumn = [currRecord objectAtIndex:0];
    int recordID = [currColumn intValue];
    self.recordIDToEdit = recordID;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}//eom


#pragma mark  Delete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        id currRecord = [self.arrPeopleInfo objectAtIndex:indexPath.row];
        id currColumn = [currRecord objectAtIndex:0];
        int recordIDToDelete = [currColumn intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from peopleInfo where peopleInfoID=%d", recordIDToDelete];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}//eom

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditViewController *editVC = [segue destinationViewController];
    editVC.delegate = self;
    editVC.recordIDToEdit = self.recordIDToEdit;
}//eom



#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//eom


@end
