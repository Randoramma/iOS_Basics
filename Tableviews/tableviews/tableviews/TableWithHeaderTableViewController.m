//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import "TableWithHeaderTableViewController.h"
#import "TableWithHeaderTableViewCell.h"
#import "TableWithHeaderDetailViewController.h"
#import "TableViewHeader.h"

@interface TableWithHeaderTableViewController ()

@end

@implementation TableWithHeaderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"places" ofType:@"plist"];
    NSArray * items = [[NSArray alloc] initWithContentsOfFile:path];
    
    
    NSMutableArray * tempPlaceList = [[NSMutableArray alloc]init];
    for (int iter = 0; iter < items.count; iter++) {
        NSDictionary * currPlaceDict = [items objectAtIndex:iter];
        NSString * title = [currPlaceDict objectForKey:@"title"];
        NSString * desc = [currPlaceDict objectForKey:@"description"];
        NSString * img = [currPlaceDict objectForKey:@"image"];
        NSString * year = [currPlaceDict objectForKey:@"year"];
        NSString * height = [currPlaceDict objectForKey:@"height"];
        NSString * cost = [currPlaceDict objectForKey:@"cost"];
        NSString * record = [currPlaceDict objectForKey:@"record"];
        
        Place * currPlace = [[Place alloc] init:title
                                    description:desc
                                          image:img
                                           year:year
                                         height:height
                                           cost:cost
                                         record:record];
        [tempPlaceList addObject:currPlace];
    }
    places = tempPlaceList;
    
    //customize the back to empty so title can centered
    UIBarButtonItem *NewButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@""
                                  style:UIBarButtonItemStylePlain
                                  target:nil
                                  action:nil];
    //setting back button
    [[self navigationItem] setBackBarButtonItem:NewButton];
    
    //change color of seperators
    self.tableView.separatorColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.25];
    
    
    //adding table view header
    self.tableView.tableHeaderView = [[TableViewHeader alloc] initWithText:@"Sky Scrapers"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableWithHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableWithHeaderTableViewCell" forIndexPath:indexPath];
    
    int currRow = (int)indexPath.row;
    Place * current = [places objectAtIndex:currRow];
    
    [cell configureCell:current];
    
    return cell;
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if( [[segue identifier] isEqualToString:@"TableWithHeaderInfo"]  )
    {
        TableWithHeaderDetailViewController * detailView = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        int currRow = (int)myIndexPath.row;
        Place * current = [places objectAtIndex:currRow];
    
        detailView.currentPlace = current;
    }
}


@end
