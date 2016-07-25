//
//  BasicView2TableViewController.m
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "BasicView2TableViewController.h"
#import "BasicView2TableViewCell.h"
#import "BasicView2DetailViewController.h"
#import "TableViewHeader.h"

@interface BasicView2TableViewController ()

@end

@implementation BasicView2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    Title = @[@"Burj Khalifa",
              @"Eiffel Tower",
              @"Empire State Building",
              @"Kingdom Tower",
              @"Taipei 101",];
    
    Description = @[@"Dubai, UAE",
                    @"Paris, France",
                    @"New York, USA",
                    @"Jeddah, Saudi Arabia",
                    @"Taipei, Taiwan",];
    
    Image = @[@"burj.jpg",
              @"Eiffel.jpg",
              @"empire.jpg",
              @"kingdomtower.jpg",
              @"Taipei.jpg",];
    
    
    //customize the back to empty so title can centered
    UIBarButtonItem *NewButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
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
    return Description.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicView2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicView2Cell" forIndexPath:indexPath];
    
    //curr row
    int row = (int)indexPath.row;
    
    cell.titleLabel.text         = Title[row];
    cell.descriptionLabel.text   = Description[row];
    cell.image.image             = [UIImage imageNamed: Image[row]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

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

    if( [[segue identifier] isEqualToString:@"showBasicView2Info"]  )
    {
        BasicView2DetailViewController * detailView = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        //curr row
        int row = (int)myIndexPath.row;
        
        detailView.DetailModal      =@[Title[row], Description[row], Image[row]];
    }


}


@end
