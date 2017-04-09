//
//  ViewController.m
//  coreData1
//
//  Created by Luis Andres Castillo Hernandez on 9/22/15.
//  Copyright © 2015 DevBros. All rights reserved.
//


#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *name;
@property (strong, nonatomic) NSMutableArray *phone;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name   = [[ NSMutableArray alloc ] init];
    self.phone  = [[ NSMutableArray alloc ] init];
    
    AppDelegate *appDelegate = [ [UIApplication sharedApplication] delegate ];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //creating request to be made
    NSFetchRequest *request = [[ NSFetchRequest alloc] init];
    
    //creating the entity name and updating request with entity
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext: context];
    [request setEntity:entityDesc];
    
    //creating predicate and adding it to the request
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", @"Dev Bros"];
    [request setPredicate:pred];
    
    //
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects =[context executeFetchRequest:request error:&error];
    if( [objects count] == 0)
    {
        NSLog(@"No matches");
    }
    else
    {
        //adding values found into array
        for(int iter = 0; iter < [objects count]; iter++)
        {
            matches = objects[iter];
            [self.name addObject: [matches valueForKey:@"name"] ];
            [self.phone addObject: [matches valueForKey:@"phone"] ];
            
        }//eofl
    }
}//eom

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender
{
    NSString * nameSaving   = @"Dev Bros";
    NSString * phoneSaving  = @"(305) 555 - 7777";
    
    //saving to core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
    
    [newContact setValue:nameSaving forKey:@"name"];
    [newContact setValue:phoneSaving forKey:@"phone"];
    
    NSError *error;
    [context save:&error];
    
    if (error != nil)
    {
        NSLog(@"errors: %@", error);
    }
    else
    {
        //adding to app array
        [self.name addObject:nameSaving];
        [self.phone addObject:phoneSaving];
        
        //reloading tableview
        [self.tableView reloadData];
    }
}//eoa


#pragma Tablev View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.name.count;
}//eom


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text         = [self.name objectAtIndex:indexPath.row];
    cell.detailTextLabel.text   = [self.phone objectAtIndex:indexPath.row];
    
    return cell;
}//eom





@end
