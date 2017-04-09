//
//  PersonsTableViewController.m
//  CoreDataApp
//
//  Created by Luis Andres Castillo Hernandez on 9/14/15.
//  Copyright (c) 2015 DevBros. All rights reserved.
//

#import "PersonsTableViewController.h"
#import "Person.h"
#import "Address.h"
#import "NewPersonViewController.h"

@interface PersonsTableViewController ()

@property (nonatomic, strong) NSMutableArray *people;

@property (nonatomic, strong) NSMutableArray *addresses;

@property (nonatomic, strong) Person *person;

@property (nonatomic, strong) Address *address;

@property (nonatomic, strong) NSArray *fetchedObjects;

@property (nonatomic, strong) NSFetchRequest *fetchedRequest;

@end

@implementation PersonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Persons";
    
    [self fetchData];
}//eom


-(void)viewDidAppear:(BOOL)animated
{
    [self fetchData];
    [self.tableView reloadData];
}//eom


-(void)fetchData
{

    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entityPerson = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_managedObjectContext];
    
    
    NSEntityDescription * entityAddress = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:_managedObjectContext];
    
    
    NSError * error;
    
    //retrieving entity Person
    [fetchRequest setEntity:entityPerson];
    NSArray * fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(fetchedObjects != nil)
    {
        _people = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    }
    
    //retrieving entity Address
    [fetchRequest setEntity:entityAddress];
    fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(fetchedObjects != nil)
    {
        _addresses = [[NSMutableArray alloc] initWithArray:fetchedObjects];
    }
    
}//eom


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_people count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    _person = [_people objectAtIndex:indexPath.row];
    
    _address = [_addresses objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", _person.firstname , _person.lastname];
    
    cell.detailTextLabel.text =  _address.address;
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString * identification = [segue identifier];
    if( [identification isEqualToString:@"newPerson"])
    {
        
        NewPersonViewController *newPersonViewCont = [segue destinationViewController ];
        
        newPersonViewCont.managedObjectContext = self.managedObjectContext;
    }
}


@end
