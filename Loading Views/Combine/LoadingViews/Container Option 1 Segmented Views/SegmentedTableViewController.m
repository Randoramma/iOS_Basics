//
//  SegmentedTableViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "SegmentedTableViewController.h"
#import "SegmentedTableViewCell.h"

@interface SegmentedTableViewController ()
{
    NSArray* movies;
}
@end

@implementation SegmentedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movies = [[NSArray alloc]initWithObjects:@"Harry Potter", @"Star Wars", @"007", @"Star Trek" , @"Transfomers",nil];
}//eom

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
   return movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SegmentedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"segmentedCell" forIndexPath:indexPath];
    
    int index = (int)indexPath.row;
    
    cell.movieName.text = movies[index];
    
    return cell;
}//eom

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
