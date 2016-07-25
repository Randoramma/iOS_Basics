//
//  MainTableViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"

#import "ContainerVCViewController.h"
#import "SegmentedMainViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController


    //MARK: View Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    options = [[NSArray alloc]initWithObjects:@"VC with containers", @"VC in Segmented Controls", nil];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellID = @"myCell";
     MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
    int index = (int)indexPath.row;
    
    NSString* currOption = options[index];
    cell.optionName.text = currOption;
    
    return cell;
}//eom

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   int index = (int)indexPath.row;
    
    NSLog(@"option %d selected",index);
    switch (index) {
        case 2:
            break;
        case 1:
            [self GoToSegmentedControl];
            break;
        case 0:
            [self GoToContainersVC];
            break;
                //
        default:
            break;
    }//eo-switch
    
}//eom
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView 
 canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView 
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView 
 moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView 
 canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}//eom

-(void)GoToContainersVC
{
    ContainerVCViewController * containerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"containerVC"];
    
    [self.navigationController pushViewController:containerVC animated:true];
}//eom

-(void)GoToSegmentedControl
{
    SegmentedMainViewController * segmentedContainerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"segmentedContainer"];
    
    [self.navigationController pushViewController:segmentedContainerVC animated:true];
}//eom






     
     
     
     
     
@end
