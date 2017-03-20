//
//  BasicViewTableViewController.m
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "BasicViewTableViewController.h"
#import "BasicViewTableViewCell.h"

@interface BasicViewTableViewController ()

@end

@implementation BasicViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

    
    
}//eom

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return Title.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BasicViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicViewCell" forIndexPath:indexPath];
    
    int row = (int)indexPath.row;
    
    cell.titleLabel.text         = Title[row];
    cell.descriptionLabel.text   = Description[row];
    cell.image.image             = [UIImage imageNamed: Image[row]];
    
    return cell;
}

@end
