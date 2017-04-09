//
//  carTableViewController.m
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

#import "carTableViewController.h"
#import "addCarViewController.h"


#import <CoreData/CoreData.h>

@interface carTableViewController ()

@property (strong) NSMutableArray * devices;

@end

@implementation carTableViewController


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
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{

    NSManagedObjectContext * managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Device"];
    
    //updating devices from core data information
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    //reloading table view data
    [self.tableView reloadData];
    
}//eom

//MARK: Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID = @"carCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
    int currRow = (int)indexPath.row;
    
    //getting data
    NSManagedObjectModel * device = [self.devices objectAtIndex:currRow];
    
    //getting car info
    NSString *currCarMake   = [device valueForKey:@"carMake"];
    NSString *currCarModel  = [device valueForKey:@"carModel"];
    NSString *currCarYear   = [device valueForKey:@"carYear"];
    
    NSString *labelText = [NSString stringWithFormat:@"%@ %@", currCarMake, currCarModel];
    //updating title label
    [cell.textLabel setText:labelText];
    
    //updating detail label
    [cell.detailTextLabel setText:currCarYear];
    
    return cell;
}

//MARK: Edit

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSManagedObjectContext * context = [self managedObjectContext];
    
    //DELETE REQUEST
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        //deleteing core data
        int index = (int)indexPath.row;
        id  itemID = [self.devices objectAtIndex:index];
        [context deleteObject:itemID];
        
        //checking if error saving values occurred
        NSError * error = nil;
        if( ![context save:&error])
        {
            NSLog(@"%@ %@", error, [error localizedDescription]);
        }
        
        //deleting from local list
        [self.devices removeObjectAtIndex:index];
        
        //deleteing from tableview
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//MARK:

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"updateCar"])
    {
        //current index
//        NSInteger index = [[self.tableView indexPathForSelectedRow] row];
        
        NSManagedObjectModel * selectDevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        addCarViewController *addView = segue.destinationViewController;
        addView.device = selectDevice;
        
    }
    else if([[segue identifier] isEqualToString:@"addCar" ])
    {
        
    }
    
    
}//eom


@end
